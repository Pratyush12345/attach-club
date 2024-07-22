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
  final UserData userData;
  const DataUpdated(this.userData);

  @override
  List<Object?> get props => [userData];
}

class ProfessionsLoading extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class ProfessionsFiltered extends EditProfileState {

  const ProfessionsFiltered();

  @override
  List<Object?> get props => [];
}