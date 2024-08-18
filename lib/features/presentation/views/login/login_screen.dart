import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/presentation/bloc/login/login_bloc.dart';
import 'package:learn_pro/features/presentation/bloc/login/login_bloc.dart';
import 'package:learn_pro/features/presentation/views/instructor_dashboard/instructor_dashboard.dart';
import 'package:learn_pro/features/presentation/views/register/register_screen.dart';
import 'package:learn_pro/features/presentation/views/student_dashboard/student_dashboard.dart';
import 'package:learn_pro/features/presentation/widgets/custom_button.dart';
import 'package:learn_pro/features/presentation/widgets/custom_textfield.dart';
import 'package:learn_pro/features/presentation/widgets/default_loading.dart';
import 'package:learn_pro/utils/app_colors.dart';
import 'package:learn_pro/utils/app_consts.dart';
import 'package:learn_pro/utils/app_images.dart';
import 'package:learn_pro/utils/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoading) {
                  setState(() {
                    isLoading = true;
                  });
                } else if (state is LoginFailed) {
                  setState(() {
                    isLoading = false;
                  });
                  Get.snackbar(
                    'Failed',
                    'Something went wrong',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else if (state is LoginSuccess) {
                  print(
                      'Login Successful: Username= ${state.loginResponseModel.user.name}');
                  print(
                      'Login Successful: Token= ${state.loginResponseModel.token}');
                  setState(() {
                    isLoading = false;
                    AppConst.email = state.loginResponseModel.user.email;
                    AppConst.token = state.loginResponseModel.token;
                    AppConst.name = state.loginResponseModel.user.name;
                    AppConst.userId = state.loginResponseModel.user.id;
                    AppConst.role = state.loginResponseModel.user.role;
                  });

                  if (state.loginResponseModel.user.role == 'student') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const StudentDashboard(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  } else if (state.loginResponseModel.user.role ==
                      'instructor') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const InstructorDashboard(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image(image: AssetImage('assets/images/book_icon.png',),
                      // width: 80,
                      // ),
                    ],
                  ),
                  SizedBox(height: 100,),
                  Row(
                    children: [
                      Text(
                        'Login',
                        style: AppStyles.whiteBold30
                            .copyWith(fontSize: 40, color: Colors.yellow),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.login,
                        size: 30,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Hey there, login in to get started!',
                    style: AppStyles.whiteBold14
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'Email',
                    controller: emailTextController,
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    title: 'Password',
                    controller: passwordTextController,
                    prefixIcon: Icons.password,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Forgot password?',
                        style: AppStyles.whiteBold14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  isLoading
                      ? const DefaultLoading()
                      : CustomButton(
                          onTap: () {
                            if (emailTextController.text.isNotEmpty &&
                                passwordTextController.text.isNotEmpty) {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginUserEvent(
                                  loginRequestModel: LoginRequestModel(
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                  ),
                                ),
                              );
                            } else {
                              Get.snackbar(
                                  'Fields Empty', 'Fill in all the fields..',
                                backgroundColor: Colors.yellow,
                                colorText: Colors.black,
                              );
                            }
                          },
                          title: 'Confirm',
                          prefixIcon: Icons.login,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Dont have an account?',
                        style: AppStyles.whiteBold14
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: AppStyles.whiteBold14
                              .copyWith(color: Colors.yellow),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
