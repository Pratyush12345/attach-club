part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class ShowSnackBar extends EditProfileState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];

}

class InitialUserData extends EditProfileState {
  final UserData userData;

  const InitialUserData(this.userData);

  @override
  List<Object?> get props => [userData];
}

class DataUpdated extends EditProfileState {
  final String name;
  final String profession;
  final String description;

  const DataUpdated(this.name, this.profession, this.description);

  @override
  List<Object?> get props => [name, profession, description];
}