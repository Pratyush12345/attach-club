import 'dart:async';
import 'dart:developer';

import 'package:attach_club/bloc/profile_privacy/profile_privacy_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_privacy_event.dart';

part 'profile_privacy_state.dart';

class ProfilePrivacyBloc
    extends Bloc<ProfilePrivacyEvent, ProfilePrivacyState> {
  final ProfilePrivacyRepository _repository;

  ProfilePrivacyBloc(this._repository) : super(ProfilePrivacyInitial()) {
    on<BasicDetailsTriggered>((event, emit) async {
      await _repository.updateBasicDetails(event.isBasicDetailEnabled);
      emit(BasicDetailsChanged(event.isBasicDetailEnabled));
    });
    on<SocialLinkTriggered>((event, emit) async {
      await _repository.updateSocialLink(event.isLinkEnabled);
      emit(SocialLinkChanged(event.isLinkEnabled));
    });
    on<ProductsTriggered>((event, emit) async {
      await _repository.updateProduct(event.isProductEnabled);
      emit(ProductsChanged(event.isProductEnabled));
    });
    on<ReviewsTriggered>((event, emit) async {
      await _repository.updateReview(event.isReviewEnabled);
      emit(ReviewsChanged(event.isReviewEnabled));
    });
    on<FetchAllStatus>((event, emit) async {
      final userData = await _repository.fetchAllStatus();
      emit(
        StatusChanged(
          isBasicDetailEnabled: userData.isBasicDetailEnabled,
          isLinkEnabled: userData.isLinkEnabled,
          isProductEnabled: userData.isProductEnabled,
          isReviewEnabled: userData.isReviewEnabled,
        ),
      );
    });
  }
}
