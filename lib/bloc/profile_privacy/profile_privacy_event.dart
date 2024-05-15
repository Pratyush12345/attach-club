part of 'profile_privacy_bloc.dart';

abstract class ProfilePrivacyEvent extends Equatable {
  const ProfilePrivacyEvent();
}

class BasicDetailsTriggered extends ProfilePrivacyEvent{
  final bool isBasicDetailEnabled;

  const BasicDetailsTriggered(this.isBasicDetailEnabled);

  @override
  List<Object?> get props => [isBasicDetailEnabled];
}

class SocialLinkTriggered extends ProfilePrivacyEvent{
  final bool isLinkEnabled;

  const SocialLinkTriggered(this.isLinkEnabled);

  @override
  List<Object?> get props => [isLinkEnabled];
}

class ProductsTriggered extends ProfilePrivacyEvent{
  final bool isProductEnabled;

  const ProductsTriggered(this.isProductEnabled);

  @override
  List<Object?> get props => [isProductEnabled];
}

class ReviewsTriggered extends ProfilePrivacyEvent{
  final bool isReviewEnabled;

  const ReviewsTriggered(this.isReviewEnabled);

  @override
  List<Object?> get props => [isReviewEnabled];
}

class FetchAllStatus extends ProfilePrivacyEvent {
  @override
  List<Object?> get props => [];
}