import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_image_repository.dart';

part 'profile_image_event.dart';

part 'profile_image_state.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final ProfileImageRepository _repository;
  DateTime? lastUpdated;
  File? profileImage;
  File? bannerImage;

  ProfileImageBloc(
    this._repository,
  ) : super(ProfileImageInitial()) {
    on<ProfileImageUploaded>((event, emit) async {
      emit(LoadingState());
      final file = File(event.profileImage.path);
      profileImage = file;
      await _repository.uploadProfilePhoto(file);
      lastUpdated = DateTime.now();
      emit(ProfileImageUpdated(file));
    });
    on<BannerImageUploaded>((event, emit) async {
      emit(LoadingState());
      final file = File(event.bannerImage.path);
      bannerImage = file;
      await _repository.uploadBanner(file);
      lastUpdated = DateTime.now();
      emit(BannerImageUpdated(file));
    });
    on<FetchImages>((event, emit) async {
      emit(LoadingState());
      profileImage = await _repository.getProfileImage();
      bannerImage = await _repository.getBannerImage();
      lastUpdated = DateTime.now();
      emit(ProfileImageUpdated(profileImage));
      emit(BannerImageUpdated(bannerImage));
      if (profileImage == null && bannerImage == null) {
        emit(ProfileImageInitial());
      }
    });
  }
}
