import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../data/data_sources/remote_datasource.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/default_loading.dart';

class UpdateCourse extends StatefulWidget {
  final int id;
  final String title;
  final String des;
  final String category;
   const UpdateCourse({super.key,required this.id, required this.title, required this.des, required this.category});

  @override
  State<UpdateCourse> createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {

  RemoteDataSource remoteDataSource = RemoteDataSource();
  TextEditingController titleTxt = TextEditingController();
  TextEditingController categoryTxt = TextEditingController();
  TextEditingController descriptionTxt = TextEditingController();
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      titleTxt.text=widget.title;
      categoryTxt.text=widget.category;
      descriptionTxt.text=widget.des;
    });
  }

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
                    'Update Course',
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
                  title: 'Update',
                  onTap: () async {
                    if (titleTxt.text.isNotEmpty &&
                        descriptionTxt.text.isNotEmpty &&
                        categoryTxt.text.isNotEmpty) {
                      setState(() {
                        isLoading=true;
                      });
                      try{
                        await remoteDataSource.updateCourse(titleTxt.text, categoryTxt.text, descriptionTxt.text,widget.id);
                        Get.snackbar(
                          'Success',
                          'Course updated successfully',
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
                          'Failed updating a course',
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
