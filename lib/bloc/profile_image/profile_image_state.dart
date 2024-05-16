part of 'profile_image_bloc.dart';

abstract class ProfileImageState extends Equatable {
  const ProfileImageState();
}

class ProfileImageInitial extends ProfileImageState {
  @override
  List<Object> get props => [];
}

class ProfileImageUpdated extends ProfileImageState {
  final File? file;

  const ProfileImageUpdated(this.file);

  @override
  List<Object?> get props => [file];
}

class BannerImageUpdated extends ProfileImageState {
  final File? file;

  const BannerImageUpdated(this.file);

  @override
  List<Object?> get props => [file];
}

class LoadingState extends ProfileImageState {
  @override
  List<Object?> get props => [];

}

class FetchedImages extends ProfileImageState {
  final File profileImage;
  final File bannerImage;

  const FetchedImages({required this.profileImage, required this.bannerImage});

  @override
  List<Object?> get props => [profileImage, bannerImage];
}

class ShowSnackBar extends ProfileImageState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}