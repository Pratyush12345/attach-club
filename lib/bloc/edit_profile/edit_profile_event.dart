part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

// class OnVerifyClicked extends EditProfileEvent {
//   final String username;
//
//   const OnVerifyClicked(this.username);
//
//   @override
//   List<Object?> get props => [];
// }

// class OnFieldsUpdated extends EditProfileEvent {
//   final String username;
//   final String name;
//   final String profession;
//   final String about;
//   final int loading;
//   final bool isUsernameUpdated;
//
//   const OnFieldsUpdated({
//     required this.username,
//     required this.name,
//     required this.profession,
//     required this.about,
//     required this.loading,
//     required this.isUsernameUpdated,
//   });
//
//   @override
//   List<Object?> get props => [username, name, profession, about];
// }

// class NextButtonClicked extends EditProfileEvent {
//   final String username;
//   final String name;
//   final String profession;
//   final String description;
//   final bool isVerified;
//
//   const NextButtonClicked(
//       this.username,
//       this.name,
//       this.profession,
//       this.description,
//       this.isVerified,
//       );
//
//   @override
//   List<Object?> get props => [];
// }

class GetUserData extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class NameUpdated extends EditProfileEvent {
  final String name;

  const NameUpdated({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}

class ProfessionUpdated extends EditProfileEvent {
  final String profession;

  const ProfessionUpdated({
    required this.profession,
  });

  @override
  List<Object?> get props => [profession];
}

class DescriptionUpdated extends EditProfileEvent {
  final String description;

  const DescriptionUpdated({
    required this.description,
  });

  @override
  List<Object?> get props => [description];
}

class UpdateTriggered extends EditProfileEvent {
  final String key;
  final String value;

  const UpdateTriggered({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [];
}
