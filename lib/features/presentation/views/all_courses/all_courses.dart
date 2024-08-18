import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';
import 'package:learn_pro/features/data/models/response/all_courses_response.dart';
import 'package:learn_pro/features/presentation/bloc/all_courses/all_courses_bloc.dart';
import 'package:learn_pro/features/presentation/views/create_course/create_course.dart';
import 'package:learn_pro/features/presentation/views/update_course/update_course.dart';
import 'package:learn_pro/features/presentation/widgets/course_template.dart';
import 'package:learn_pro/features/presentation/widgets/default_loading.dart';
import 'package:learn_pro/features/presentation/widgets/failed_widget.dart';
import 'package:learn_pro/utils/app_colors.dart';
import 'package:learn_pro/utils/app_consts.dart';
import 'package:learn_pro/utils/app_images.dart';
import 'package:learn_pro/utils/app_styles.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  RemoteDataSource remoteDataSource = RemoteDataSource();

  List<AllCoursesResponse>? allCourses;
  bool isLoading = true;
  bool isFailed = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllCoursesBloc>(context).add(AllCoursesStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: BlocListener<AllCoursesBloc, AllCoursesState>(
          listener: (context, state) {
            if (state is AllCoursesLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is AllCoursesFailed) {
              setState(() {
                isLoading = false;
                isFailed = true;
              });
              Get.snackbar(
                'Failed',
                'Something went wrong',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            } else if (state is AllCoursesSuccess) {
              setState(() {
                allCourses = state.allCourses;
                isFailed = false;
                isLoading = false;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.school,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'All Courses',
                      style: AppStyles.whiteBold20,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AllCoursesBloc>(context)
                            .add(AllCoursesStartEvent());
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                    AppConst.role == 'instructor'
                        ? IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const CreateCoursePage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ],
                ),
                isLoading
                    ? const Expanded(child: DefaultLoading())
                    : isFailed
                        ? const FailedWidget()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: allCourses!.length,
                                itemBuilder: (context, index) {
                                  return CourseTemplate(
                                    onEnrollTap: AppConst.role == 'student'
                                        ? () async {
                                            try {
                                              await remoteDataSource
                                                  .enrollIntoCourse(
                                                      allCourses![index].id);
                                              Get.snackbar(
                                                'Success',
                                                'You have enrolled to this course',
                                                backgroundColor:
                                                    Colors.lightGreenAccent,
                                                colorText: Colors.black,
                                              );
                                            } catch (e) {
                                              Get.snackbar(
                                                'Failed',
                                                'Something went wrong',
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                              );
                                            }
                                          }
                                        : null,
                                    description: allCourses![index].description,
                                    title: allCourses![index].title,
                                    id: allCourses![index].id,
                                    instructor:
                                        allCourses![index].instructor.name,
                                    preImageIcon: AppImages.courseIcon,
                                    onEditTap: AppConst.role == 'instructor'
                                        ? () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    UpdateCourse(
                                                  id: allCourses![index].id,
                                                      title: allCourses![index].title,
                                                      category: allCourses![index].category,
                                                      des: allCourses![index].description,
                                                ),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return SlideTransition(
                                                    position: Tween<Offset>(
                                                      begin: const Offset(
                                                          0.0, 0.0),
                                                      end: Offset.zero,
                                                    ).animate(animation),
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        : null,
                                  );
                                }),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
