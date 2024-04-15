import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'profile_image_repository.dart';

part 'profile_image_event.dart';

part 'profile_image_state.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final CoreRepository _coreRepository;
  final ProfileImageRepository _repository;

  ProfileImageBloc(
    this._coreRepository,
    this._repository,
  ) : super(ProfileImageInitial()) {
    on<ProfileImageUploaded>((event, emit) async {
      emit(LoadingState());
      final file = File(event.profileImage.path);
      await _repository.uploadProfilePhoto(file);
      emit(ProfileImageUpdated(file));
    });
    on<BannerImageUploaded>((event, emit) async {
      emit(LoadingState());
      final file = File(event.profileImage.path);
      await _repository.uploadBanner(file);
      emit(BannerImageUpdated(file));
    });
    on<FetchImages>((event, emit) async {
      emit(LoadingState());
      final profileImage = await _repository.getProfileImage();
      final bannerImage = await _repository.getBannerImage();
      emit(FetchedImages(
        profileImage: profileImage,
        bannerImage: bannerImage,
      ));
      emit(BannerImageUpdated(bannerImage));
    });
  }
}
