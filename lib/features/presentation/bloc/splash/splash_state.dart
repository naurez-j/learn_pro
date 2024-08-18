part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

final class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState{
  final String tokenAvailable;
  SplashSuccess({required this.tokenAvailable});
}
class SplashFailed extends SplashState{}
class SplashLoading extends SplashState{}


