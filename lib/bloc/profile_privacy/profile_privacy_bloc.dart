import 'package:attach_club/bloc/profile_privacy/profile_privacy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_privacy_event.dart';

part 'profile_privacy_state.dart';


//TODO: Doesn't initialize every time
class ProfilePrivacyBloc
    extends Bloc<ProfilePrivacyEvent, ProfilePrivacyState> {
  final ProfilePrivacyRepository _repository;

  ProfilePrivacyBloc(this._repository) : super(ProfilePrivacyInitial()) {
    on<BasicDetailsTriggered>((event, emit) async {
      emit(LoadingState());
      await _repository.updateBasicDetails(event.isBasicDetailEnabled);
      emit(BasicDetailsChanged(event.isBasicDetailEnabled));
    });
    on<SocialLinkTriggered>((event, emit) async {
      emit(LoadingState());
      await _repository.updateSocialLink(event.isLinkEnabled);
      emit(SocialLinkChanged(event.isLinkEnabled));
    });
    on<ProductsTriggered>((event, emit) async {
      emit(LoadingState());
      await _repository.updateProduct(event.isProductEnabled);
      emit(ProductsChanged(event.isProductEnabled));
    });
    on<ReviewsTriggered>((event, emit) async {
      emit(LoadingState());
      await _repository.updateReview(event.isReviewEnabled);
      emit(ReviewsChanged(event.isReviewEnabled));
    });
    on<FetchAllStatus>((event, emit) async {
      emit(LoadingState());
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
