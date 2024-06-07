part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
}

class CheckLoginStatus extends SplashScreenEvent{
  final bool isInsideIntro;

  CheckLoginStatus({this.isInsideIntro = false});


  @override
  List<Object?> get props => [];
}
