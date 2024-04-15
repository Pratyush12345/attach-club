part of 'profile_image_bloc.dart';

abstract class ProfileImageEvent extends Equatable {
  const ProfileImageEvent();
}

class ProfileImageUploaded extends ProfileImageEvent {
  final XFile profileImage;

  const ProfileImageUploaded(this.profileImage);

  @override
  List<Object?> get props => [profileImage];
}

class BannerImageUploaded extends ProfileImageEvent {
  final XFile profileImage;

  const BannerImageUploaded(this.profileImage);

  @override
  List<Object?> get props => [profileImage];
}

class FetchImages extends ProfileImageEvent {
  @override
  List<Object?> get props => [];
}
