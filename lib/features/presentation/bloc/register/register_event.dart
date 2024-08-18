part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final RegisterRequestModel registerRequestModel;
  RegisterUserEvent({required this.registerRequestModel});
}
