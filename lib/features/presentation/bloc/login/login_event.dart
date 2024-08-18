part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent{
  final LoginRequestModel loginRequestModel;
  LoginUserEvent({required this.loginRequestModel});
}
