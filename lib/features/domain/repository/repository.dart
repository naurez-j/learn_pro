import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/data/models/request/register_user_request_model.dart';
import 'package:learn_pro/features/data/models/response/all_courses_response.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';
import 'package:learn_pro/features/data/models/response/register_response_model.dart';

abstract class RepoInitial {
  ///Remote data Access
  Future<LoginResponseModel> loginUser(LoginRequestModel loginRequestModel);
  Future<RegisterResponseModel>registerUser(RegisterRequestModel registerRequestModel);
  Future<List<AllCoursesResponse>>getAllCourses();
  Future<List<AllCoursesResponse>>getEnrolledCourses();

  ///Local data Access
  Future<void>saveAuthToken(String token);

}