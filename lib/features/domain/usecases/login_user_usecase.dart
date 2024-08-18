import 'package:learn_pro/features/data/models/request/login_request_model.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';

import '../repository/repository.dart';

class LoginUserUsecase {
  final RepoInitial repository;

  LoginUserUsecase(this.repository);

  Future<LoginResponseModel> loginUser(
      LoginRequestModel loginRequestModel) async {
    try {
      return await repository.loginUser(loginRequestModel);
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }
}
