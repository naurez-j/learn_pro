import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/models/response/all_courses_response.dart';
import 'package:learn_pro/features/presentation/bloc/all_courses/all_courses_bloc.dart';
import 'package:learn_pro/features/presentation/widgets/course_template.dart';
import 'package:learn_pro/features/presentation/widgets/default_loading.dart';
import 'package:learn_pro/features/presentation/widgets/failed_widget.dart';
import 'package:learn_pro/utils/app_images.dart';
import 'package:learn_pro/utils/app_styles.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
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
      backgroundColor: Colors.black,
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
                    Icon(
                      Icons.school,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'All Courses',
                      style: AppStyles.whiteBold20,
                    ),
                  ],
                ),
                isLoading
                    ? Expanded(child: DefaultLoading())
                    : isFailed
                        ? FailedWidget()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: allCourses!.length,
                                itemBuilder: (context, index) {
                                  return CourseTemplate(
                                      description:
                                          allCourses![index].description,
                                      title: allCourses![index].title,
                                      id: allCourses![index].id,
                                      instructor:
                                          allCourses![index].instructor.name,
                                      preImageIcon: AppImages.courseIcon);
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
