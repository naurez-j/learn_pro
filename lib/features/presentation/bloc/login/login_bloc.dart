import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';
import 'package:meta/meta.dart';

import '../../../data/models/request/login_request_model.dart';
import '../../../data/repo_implementation/repo_impl.dart';
import '../../../domain/repository/repository.dart';
import '../../../domain/usecases/login_user_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  RepoInitial repoInitial = RepoImpl();
  LoginBloc() : super(LoginInitial()) {
    LoginUserUsecase loginUserUsecase = LoginUserUsecase(repoInitial);
    LocalStorage localStorage = LocalStorage();
    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final LoginResponseModel loginResponseModel;
        loginResponseModel=await loginUserUsecase.loginUser(event.loginRequestModel);
        await localStorage.saveToken(loginResponseModel.token);
        emit(LoginSuccess(loginResponseModel: loginResponseModel));
      } catch (e) {
        print(e);
        emit(LoginFailed());
      }
    });
  }
}
