import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';
import 'package:learn_pro/features/presentation/bloc/student_dashboard/student_dashboard_bloc.dart';
import 'package:learn_pro/features/presentation/views/all_courses/all_courses.dart';
import 'package:learn_pro/features/presentation/views/login/login_screen.dart';
import 'package:learn_pro/features/presentation/widgets/course_template.dart';
import 'package:learn_pro/features/presentation/widgets/custom_button.dart';
import 'package:learn_pro/features/presentation/widgets/default_loading.dart';
import 'package:learn_pro/features/presentation/widgets/failed_widget.dart';
import 'package:learn_pro/utils/app_colors.dart';
import 'package:learn_pro/utils/app_consts.dart';
import 'package:learn_pro/utils/app_images.dart';
import 'package:learn_pro/utils/app_styles.dart';

import '../../../data/models/response/all_courses_response.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  LocalStorage localStorage = LocalStorage();
  List<AllCoursesResponse>? enrolledCourses;
  bool isLoading = true;
  bool isFailed = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentDashboardBloc>(context)
        .add(StudentDashboardStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<StudentDashboardBloc, StudentDashboardState>(
            listener: (context, state) {
              if (state is StudentDashboardLoading) {
                setState(() {
                  isLoading = true;
                });
              }
              if (state is StudentDashboardFailed) {
                setState(() {
                  isFailed = true;
                  isLoading = false;
                });
              }
              if (state is StudentDashboardSuccess) {
                setState(() {
                  enrolledCourses = state.allCourses;
                  isFailed = false;
                  isLoading = false;
                });
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ${AppConst.name}',
                            style: AppStyles.whiteBold30,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          const Text(
                            "What's the plan today?",
                            style: AppStyles.whiteBold14,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    IconButton(
                      onPressed: () async{
                        try{
                          await remoteDataSource.logoutUser();
                          await localStorage.deleteAuthToken();
                          setState(() {
                            AppConst.token='';
                            AppConst.role='';
                            AppConst.name='';
                            AppConst.email='';
                            AppConst.userId=0;
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              const LoginScreen(),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        }
                        catch(e){
                          Get.snackbar(
                            'Failed',
                            'Could not log you out',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.login,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xffffe05b),
                      Color(0xffffd700),
                    ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'LearnPro',
                                style: AppStyles.blackBold14
                                    .copyWith(fontSize: 30),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                'Premium',
                                style: AppStyles.blackBold14
                                    .copyWith(fontSize: 30),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                "Learn More with LearnPro",
                                style: AppStyles.blackBold14
                                    .copyWith(fontSize: 10),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Image(
                          image: AssetImage(AppImages.studentImg),
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                CustomButton(title: 'View All Courses', onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AllCoursesScreen(),
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
                }, prefixIcon: Icons.school,),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text(
                      'Enrolled Courses',
                      style: AppStyles.whiteBold20,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    
                    IconButton(onPressed: (){
                      BlocProvider.of<StudentDashboardBloc>(context)
                          .add(StudentDashboardStarted());
                    }, icon: Icon(Icons.refresh,color: Colors.white,),),
                    
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: isLoading
                      ? const DefaultLoading()
                      : isFailed
                      ? const FailedWidget()
                      : ListView.builder(
                    itemCount: enrolledCourses!.length,
                    itemBuilder: (context, index) {
                      return CourseTemplate(
                        onDeleteTap: ()async{
                          try{
                            await remoteDataSource.unEnrollCourse(enrolledCourses![index].id);
                            BlocProvider.of<StudentDashboardBloc>(context)
                                .add(StudentDashboardStarted());
                            Get.snackbar(
                              'Success', 'Un-Enrolled Successfully',
                              backgroundColor: Colors.lightGreenAccent,
                              colorText: Colors.black,
                            );
                          }
                          catch(e){
                            Get.snackbar(
                              'Failed', 'Something went wrong...',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        instructor: enrolledCourses![index].instructor.name,
                        description:
                        enrolledCourses![index].description,
                        title: enrolledCourses![index].title,
                        id: enrolledCourses![index].id,
                        preImageIcon: AppImages.courseIcon,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
