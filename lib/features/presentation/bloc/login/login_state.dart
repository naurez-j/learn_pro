part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponseModel;
  LoginSuccess({required this.loginResponseModel});
}

class LoginFailed extends LoginState {}
