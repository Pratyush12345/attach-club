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

class ConnectButtonPressed extends ProfileEvent {
  final String userUid;

  const ConnectButtonPressed(this.userUid);

  @override
  List<Object?> get props => [userUid];
}

class QueryWhatsappIconClicked extends ProfileEvent {
  // final ConnectionRequest request;
  final String phoneNo;

  const QueryWhatsappIconClicked(this.phoneNo);

  @override
  List<Object?> get props => [phoneNo];
}

class SaveContact extends ProfileEvent {

  const SaveContact();

  @override
  List<Object?> get props => [];
}
