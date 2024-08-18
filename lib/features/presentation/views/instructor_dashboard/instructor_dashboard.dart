import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_consts.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_styles.dart';
import '../../widgets/custom_button.dart';
import '../all_courses/all_courses.dart';
import '../login/login_screen.dart';

class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {

  RemoteDataSource remoteDataSource = RemoteDataSource();
  LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                          "Let' manage the courses!",
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
                              style:
                                  AppStyles.blackBold14.copyWith(fontSize: 30),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              'Premium',
                              style:
                                  AppStyles.blackBold14.copyWith(fontSize: 30),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              "Teach More with LearnPro",
                              style:
                                  AppStyles.blackBold14.copyWith(fontSize: 10),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Image(
                        image: AssetImage(AppImages.teacherImg),
                        width: 180,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                title: 'View All Courses',
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AllCoursesScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
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
                prefixIcon: Icons.school,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    'Analytics',
                    style: AppStyles.whiteBold20,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),

                  // IconButton(onPressed: (){
                  //   BlocProvider.of<StudentDashboardBloc>(context)
                  //       .add(StudentDashboardStarted());
                  // }, icon: Icon(Icons.refresh,color: Colors.white,),),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
