part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetUserData extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class CheckActiveStatus extends HomeEvent {
  @override
  List<Object?> get props => [];
}
