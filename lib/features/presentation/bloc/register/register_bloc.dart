import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/data/models/request/register_user_request_model.dart';
import 'package:learn_pro/features/data/models/response/register_response_model.dart';
import 'package:learn_pro/features/domain/usecases/register_user_usecase.dart';
import 'package:meta/meta.dart';

import '../../../data/repo_implementation/repo_impl.dart';
import '../../../domain/repository/repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RepoInitial repoInitial = RepoImpl();

  RegisterBloc() : super(RegisterInitial()) {
    RegisterUserUsecase registerUserUsecase = RegisterUserUsecase(repoInitial);
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final RegisterResponseModel registerResponseModel;
        registerResponseModel =
            await registerUserUsecase.registerUser(event.registerRequestModel);
        emit(RegisterSuccess(registerResponseModel: registerResponseModel));
      } catch (e) {
        print(e);
        emit(RegisterFailed());
      }
    });
  }
}
