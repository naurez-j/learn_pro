import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/presentation/views/login/login_screen.dart';
import 'package:learn_pro/utils/app_colors.dart';
import 'package:learn_pro/utils/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              onPressed: () {
                Get.to(() => const LoginScreen());
              },
              child: const Text(
                'Get Started',
                style: AppStyles.blackBold14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
