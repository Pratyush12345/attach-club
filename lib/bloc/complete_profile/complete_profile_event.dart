part of 'complete_profile_bloc.dart';

abstract class CompleteProfileEvent extends Equatable {
  const CompleteProfileEvent();
}

class OnVerifyClicked extends CompleteProfileEvent {
  final String username;

  const OnVerifyClicked(this.username);

  @override
  List<Object?> get props => [];
}

class OnFieldsUpdated extends CompleteProfileEvent {
  final String username;
  final String name;
  final String profession;
  final String about;
  final int loading;
  final bool isUsernameUpdated;

  const OnFieldsUpdated({
    required this.username,
    required this.name,
    required this.profession,
    required this.about,
    required this.loading,
    required this.isUsernameUpdated,
  });

  @override
  List<Object?> get props => [username, name, profession, about];
}

class NextButtonClicked extends CompleteProfileEvent {
  final String username;
  final String name;
  final String profession;
  final String description;

  const NextButtonClicked(
    this.username,
    this.name,
    this.profession,
    this.description,
  );

  @override
  List<Object?> get props => [];
}
