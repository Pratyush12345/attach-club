part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetUserData extends ProfileEvent {
  final String? uid;

  const GetUserData({this.uid});

  @override
  List<Object?> get props => [uid];
}

class ReviewSubmitted extends ProfileEvent {
  final int selectedStars;
  final String name;
  final String feedback;
  final UserData userData;
  final String profileUid;

  const ReviewSubmitted(
    this.selectedStars,
    this.name,
    this.feedback,
    this.userData,
    this.profileUid,
  );

  @override
  List<Object?> get props => [selectedStars, name, feedback, userData, profileUid];
}
