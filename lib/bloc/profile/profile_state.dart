part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class UserDataUpdated extends ProfileState {
  final UserData userData;

  const UserDataUpdated(this.userData);

  @override
  List<Object?> get props => [userData];

}

class OtherUserDataUpdated extends ProfileState {
  // final UserData userData;

  const OtherUserDataUpdated();

  @override
  List<Object?> get props => [];

}
