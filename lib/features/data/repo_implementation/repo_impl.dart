import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';
import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/data/models/response/all_courses_response.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';
import 'package:learn_pro/features/data/models/response/register_response_model.dart';
import 'package:learn_pro/features/domain/repository/repository.dart';

import '../models/request/register_user_request_model.dart';

class RepoImpl extends RepoInitial {
  RemoteDataSource remoteDataSource = RemoteDataSource();
  LocalStorage localStorage = LocalStorage();

  @override
  Future<LoginResponseModel> loginUser(
      LoginRequestModel loginRequestModel) async {
    try {
      final LoginResponseModel loginResponseModel;
      loginResponseModel = await remoteDataSource.loginUser(loginRequestModel);
      return loginResponseModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await localStorage.saveToken(token);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<RegisterResponseModel> registerUser(
      RegisterRequestModel registerRequestModel) async {
    try {
      final RegisterResponseModel registerResponseModel;
      registerResponseModel =
          await remoteDataSource.registerUser(registerRequestModel);
      return registerResponseModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<AllCoursesResponse>> getAllCourses() async {
    try {
      final List<AllCoursesResponse> allCourses =
          await remoteDataSource.getAllCourses();
      return allCourses;
    } catch (e) {
      throw Exception('Failed to get courses: $e');
    }
  }

  @override
  Future<List<AllCoursesResponse>> getEnrolledCourses() async{
    try {
      final List<AllCoursesResponse> allCourses = await remoteDataSource.getEnrolledCourses();
      return allCourses;
    } catch (e) {
      throw Exception('Failed to get courses: $e');
    }
  }
}
