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
  String profileImage = "";
  String bannerImage = "";

  ProfileImageBloc(
    this._repository,
  ) : super(ProfileImageInitial()) {
    on<ProfileImageUploaded>((event, emit) async {
      emit(LoadingState());
      final file = File(event.profileImage.path);
      profileImage = await _repository.uploadProfilePhoto(file);
      lastUpdated = DateTime.now();
      emit(ProfileImageUpdated(profileImage));
    });
    on<BannerImageUploaded>((event, emit) async {
      emit(LoadingState());
      final file = File(event.bannerImage.path);
      bannerImage = await _repository.uploadBanner(file);
      lastUpdated = DateTime.now();
      emit(BannerImageUpdated(profileImage));
    });
    on<FetchImages>((event, emit) async {
      try {
        emit(LoadingState());
        profileImage = await _repository.getProfileImage();
        bannerImage = await _repository.getBannerImage();
        lastUpdated = DateTime.now();
        emit(ProfileImageUpdated(profileImage));
        emit(BannerImageUpdated(bannerImage));
        if (profileImage.isEmpty && bannerImage.isEmpty) {
          emit(ProfileImageInitial());
        }
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<ProfileImageDeleted>((event, emit) async {
      emit(LoadingState());
      await _repository.deleteProfileImage();
      profileImage = "";
      lastUpdated = DateTime.now();
      emit(ProfileImageUpdated(profileImage));
    });
    on<BannerImageDeleted>((event, emit) async {
      emit(LoadingState());
      await _repository.deleteBannerImage();
      bannerImage = "";
      lastUpdated = DateTime.now();
      emit(BannerImageUpdated(bannerImage));
    });
  }
}
