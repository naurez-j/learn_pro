import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/data/models/request/register_user_request_model.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';
import 'package:learn_pro/features/data/models/response/register_response_model.dart';

import '../repository/repository.dart';

class RegisterUserUsecase {
  final RepoInitial repository;

  RegisterUserUsecase(this.repository);

  Future<RegisterResponseModel> registerUser(
      RegisterRequestModel registerRequestModel) async {
    try {
      return await repository.registerUser(registerRequestModel);
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }
}
