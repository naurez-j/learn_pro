import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import the Bloc package
import 'package:get/get.dart';
import 'package:learn_pro/features/presentation/bloc/all_courses/all_courses_bloc.dart';
import 'package:learn_pro/features/presentation/bloc/login/login_bloc.dart';
import 'package:learn_pro/features/presentation/bloc/register/register_bloc.dart';
import 'package:learn_pro/features/presentation/bloc/student_dashboard/student_dashboard_bloc.dart';
import 'package:learn_pro/features/presentation/views/splash/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(),),
        BlocProvider(create: (context) => RegisterBloc(),),
        BlocProvider(create: (context) => AllCoursesBloc(),),
        BlocProvider(create: (context) => StudentDashboardBloc(),),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
