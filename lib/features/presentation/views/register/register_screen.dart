import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/models/request/register_user_request_model.dart';
import 'package:learn_pro/features/presentation/bloc/register/register_bloc.dart';
import 'package:learn_pro/features/presentation/widgets/custom_button.dart';
import 'package:learn_pro/features/presentation/widgets/default_loading.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  bool isStudent = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if(state is RegisterSuccess){
                  setState(() {
                    isLoading=false;
                  });
                  Get.snackbar(
                    'Register Successful',
                    'Registered ${state.registerResponseModel.user.name} as a ${state.registerResponseModel.user.role}',
                    backgroundColor: Colors.lightGreenAccent,
                    colorText: Colors.black,
                  );
                }
                else if (state is RegisterLoading){
                  setState(() {
                    isLoading=true;
                  });
                }
                else if (state is RegisterFailed){
                  setState(() {
                    isLoading=false;
                  });
                  Get.snackbar(
                    'Failed',
                    'Something went wrong',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Text(
                        'Register',
                        style: AppStyles.whiteBold30
                            .copyWith(fontSize: 40, color: Colors.yellow),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.chrome_reader_mode_outlined,
                        size: 30,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Register a new account to login.',
                    style: AppStyles.whiteBold14
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'Name',
                    controller: nameTextController,
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(
                    height: 15,
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
                    obscureText: true,
                    title: 'Password',
                    controller: passwordTextController,
                    prefixIcon: Icons.password,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'You are a :',
                        style: AppStyles.whiteBold14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isStudent ? Colors.yellow : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isStudent = true;
                          });
                        },
                        child: const Text(
                          'Student',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isStudent ? Colors.white : Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            isStudent = false;
                          });
                        },
                        child: const Text(
                          'Instructor',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isLoading?
                  const DefaultLoading():
                  CustomButton(title: 'Submit', onTap: () {
                    if(
                    passwordTextController.text.isNotEmpty &&
                    emailTextController.text.isNotEmpty &&
                    nameTextController.text.isNotEmpty
                    ){
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterUserEvent(
                              registerRequestModel: RegisterRequestModel(
                                password: passwordTextController.text,
                                email: emailTextController.text,
                                name: nameTextController.text,
                                role: isStudent ? 'student' : 'instructor',
                              )));
                    }
                    else{
                      Get.snackbar(
                        'Fields Empty', 'Fill in all the fields..',
                        backgroundColor: Colors.yellow,
                        colorText: Colors.black,
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
