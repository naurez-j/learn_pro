import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';
import 'package:learn_pro/features/presentation/widgets/custom_button.dart';
import 'package:learn_pro/features/presentation/widgets/custom_textfield.dart';
import 'package:learn_pro/features/presentation/widgets/default_loading.dart';
import 'package:learn_pro/utils/app_colors.dart';
import 'package:learn_pro/utils/app_styles.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {

  RemoteDataSource remoteDataSource = RemoteDataSource();
  TextEditingController titleTxt = TextEditingController();
  TextEditingController categoryTxt = TextEditingController();
  TextEditingController descriptionTxt = TextEditingController();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create Course',
                    style: AppStyles.whiteBold20,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: titleTxt,
                  title: 'Title',
                  prefixIcon: Icons.title),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: descriptionTxt,
                  title: 'Description',
                  prefixIcon: Icons.description),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: categoryTxt,
                  title: 'Category',
                  prefixIcon: Icons.category),
              SizedBox(
                height: 20,
              ),
              isLoading?
              DefaultLoading():
              CustomButton(
                  title: 'Create',
                  onTap: () async {
                    if (titleTxt.text.isNotEmpty &&
                        descriptionTxt.text.isNotEmpty &&
                        categoryTxt.text.isNotEmpty) {
                      setState(() {
                        isLoading=true;
                      });
                      try{
                        await remoteDataSource.createCourse(titleTxt.text, categoryTxt.text, descriptionTxt.text);
                        Get.snackbar(
                          'Success',
                          'Course created successfully',
                          backgroundColor: Colors.lightGreenAccent,
                          colorText: Colors.black,
                        );
                        setState(() {
                          isLoading=false;
                        });
                      }catch(e){
                        setState(() {
                          isLoading=false;
                        });
                        Get.snackbar(
                          'Failed',
                          'Failed creating a course',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                    else {
                      Get.snackbar(
                        'Fields Empty',
                        'Fill all fields',
                        backgroundColor: Colors.yellow,
                        colorText: Colors.black,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
