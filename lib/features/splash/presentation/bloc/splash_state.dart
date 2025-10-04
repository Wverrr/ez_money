part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();  

  @override
  List<Object> get props => [];
}
class SplashInitial extends SplashState {}

class SplashGoToOnboarding  extends SplashState {}

class SplashGoToHome extends SplashState {
  final int userId;

  const SplashGoToHome(this.userId);

  @override
  List<Object> get props => [userId];
}
