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
  final String state;
  final String city;
  final String country;
  final String pincode;
  final String phoneNo;
  final bool isUsernameUpdated;

  const OnFieldsUpdated({
    required this.username,
    required this.name,
    required this.profession,
    required this.about,
    required this.loading,
    required this.state,
    required this.city,
    required this.country,
    required this.pincode,
    required this.phoneNo,
    required this.isUsernameUpdated,
  });

  @override
  List<Object?> get props => [
        username,
        name,
        profession,
        about,
        loading,
        state,
        city,
        country,
        pincode,
        isUsernameUpdated
      ];
}

class NextButtonClicked extends CompleteProfileEvent {
  final String username;
  final String name;
  final String profession;
  final String description;
  final String state;
  final String city;
  final String pincode;
  final String country;
  final String phoneNo;
  final bool isVerified;

  const NextButtonClicked({
    required this.username,
    required this.name,
    required this.profession,
    required this.description,
    required this.state,
    required this.city,
    required this.pincode,
    required this.country,
    required this.isVerified,
    required this.phoneNo,
  });

  @override
  List<Object?> get props => [];
}

class GetUserData extends CompleteProfileEvent {
  @override
  List<Object?> get props => [];
}
