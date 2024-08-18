import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:learn_pro/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:learn_pro/features/presentation/views/instructor_dashboard/instructor_dashboard.dart';
import 'package:learn_pro/features/presentation/views/login/login_screen.dart';
import 'package:learn_pro/features/presentation/views/student_dashboard/student_dashboard.dart';
import 'package:learn_pro/utils/app_colors.dart';
import 'package:learn_pro/utils/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SplashStarted());
  }

  Future<void>fakeDelay()async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
      ),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            if (state.tokenAvailable == 'no_token') {
              fakeDelay();

            } else if (state.tokenAvailable == 'student') {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const StudentDashboard(),
                ),
                (Route<dynamic> route) => false,
              );
            } else if (state.tokenAvailable == 'instructor') {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const InstructorDashboard(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          } else if (state is SplashLoading) {

          } else if (state is SplashFailed) {
            Get.snackbar(
              'Failed',
              'Something wrong. Re-open the app',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Replace with logo
              const Icon(
                Icons.book_outlined,
                color: Colors.yellow,
                size: 50,
              ),
              const Text(
                'LearnPro',
                style: AppStyles.whiteBold30,
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.yellow,
              //   ),
              //   onPressed: () {
              //     Get.to(() => const LoginScreen());
              //   },
              //   child: const Text(
              //     'Get Started',
              //     style: AppStyles.blackBold14,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
