part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState{
  final RegisterResponseModel registerResponseModel;
  RegisterSuccess({required this.registerResponseModel});
}
class RegisterFailed extends RegisterState{}
class RegisterLoading extends RegisterState{}
