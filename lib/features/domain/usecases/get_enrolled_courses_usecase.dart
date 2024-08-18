import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/data/models/response/all_courses_response.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';

import '../repository/repository.dart';

class GetEnrolledCoursesUsecase {
  final RepoInitial repository;

  GetEnrolledCoursesUsecase(this.repository);

  Future<List<AllCoursesResponse>> getCourses() async {
    try {
      return await repository.getEnrolledCourses();
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }
}
