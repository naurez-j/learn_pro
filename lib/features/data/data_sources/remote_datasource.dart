import 'package:dio/dio.dart';
import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/data/models/request/register_user_request_model.dart';
import 'package:learn_pro/features/data/models/response/register_response_model.dart';
import 'package:learn_pro/utils/app_consts.dart';

import '../models/response/all_courses_response.dart';
import '../models/response/login_response_model.dart';

class RemoteDataSource {
  Dio dio = Dio();

  Future<LoginResponseModel> loginUser(
      LoginRequestModel loginRequestModel) async {
    try {
      final response = await dio.post(
          'https://festive-clarke.93-51-37-244.plesk.page/api/v1/login',
          data: loginRequestModel.toJson());
      final responseData = response.data;
      return LoginResponseModel.fromJson(responseData);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RegisterResponseModel> registerUser(
      RegisterRequestModel registerRequestModel) async {
    try {
      final response = await dio.post(
          'https://festive-clarke.93-51-37-244.plesk.page/api/v1/register',
          data: registerRequestModel.toJson());
      final responseData = response.data;
      return RegisterResponseModel.fromJson(responseData);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<AllCoursesResponse>> getAllCourses() async {
    try {
      final response = await dio.get(
        'https://festive-clarke.93-51-37-244.plesk.page/api/v1/courses',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConst.token}',
          },
        ),
      );
      final List responseData = response.data;
      print(response);
      return responseData
          .map((course) => AllCoursesResponse.fromJson(course))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<AllCoursesResponse>> getEnrolledCourses() async {
    try {
      final response = await dio.get(
        'https://festive-clarke.93-51-37-244.plesk.page/api/v1/my-courses',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConst.token}',
          },
        ),
      );
      final List responseData = response.data;
      print(response);
      return responseData
          .map((course) => AllCoursesResponse.fromJson(course))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Direct Usage (Without clean architecture and BLOC)
  Future<void> enrollIntoCourse(int courseId) async {
    try {
      await dio.post(
        'https://festive-clarke.93-51-37-244.plesk.page/api/v1/courses/${courseId}/enroll',
        data: {"course": courseId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConst.token}',
          },
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> unEnrollCourse(int courseId) async {
    try {
      await dio.delete(
        'https://festive-clarke.93-51-37-244.plesk.page/api/v1/courses/${courseId}/unenroll',
        data: {"course": courseId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConst.token}',
          },
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
