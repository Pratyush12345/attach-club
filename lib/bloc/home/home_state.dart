part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class UserDataUpdated extends HomeState {
  final UserData userData;

  const UserDataUpdated(this.userData);

  @override
  List<Object?> get props => [userData];

}

class UserBlockedStatus extends HomeState {
  @override
  List<Object> get props => [];
}