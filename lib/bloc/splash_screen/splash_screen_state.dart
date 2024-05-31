part of 'splash_screen_bloc.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();
}

class SplashScreenInitial extends SplashScreenState {
  @override
  List<Object> get props => [];
}

class NavigateToSignup extends SplashScreenState {
  @override
  List<Object?> get props => [];
}

class NavigateToOnboarding extends SplashScreenState {
  @override
  List<Object?> get props => [];
}

class NavigateToDashboard extends SplashScreenState {
  @override
  List<Object?> get props => [];
}

class ShowSnackBar extends SplashScreenState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}

class NavigateToVerifyPhone extends SplashScreenState {
  @override
  List<Object?> get props => [];
}