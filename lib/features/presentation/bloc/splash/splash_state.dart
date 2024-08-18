part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

final class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState{}
class SplashFailed extends SplashState{}
class SplashLoading extends SplashState{}


