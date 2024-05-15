part of 'profile_privacy_bloc.dart';

abstract class ProfilePrivacyState extends Equatable {
  const ProfilePrivacyState();
}

class ProfilePrivacyInitial extends ProfilePrivacyState {
  @override
  List<Object> get props => [];
}

class BasicDetailsChanged extends ProfilePrivacyState {
  final bool isBasicDetailEnabled;

  const BasicDetailsChanged(this.isBasicDetailEnabled);

  @override
  List<Object?> get props => [isBasicDetailEnabled];
}

class SocialLinkChanged extends ProfilePrivacyState {
  final bool isLinkEnabled;

  const SocialLinkChanged(this.isLinkEnabled);

  @override
  List<Object?> get props => [isLinkEnabled];
}

class ProductsChanged extends ProfilePrivacyState {
  final bool isProductEnabled;

  const ProductsChanged(this.isProductEnabled);

  @override
  List<Object?> get props => [isProductEnabled];
}

class ReviewsChanged extends ProfilePrivacyState {
  final bool isReviewEnabled;

  const ReviewsChanged(this.isReviewEnabled);

  @override
  List<Object?> get props => [isReviewEnabled];
}

class StatusChanged extends ProfilePrivacyState {
  final bool isBasicDetailEnabled;
  final bool isLinkEnabled;
  final bool isProductEnabled;
  final bool isReviewEnabled;

  const StatusChanged({
    required this.isBasicDetailEnabled,
    required this.isLinkEnabled,
    required this.isProductEnabled,
    required this.isReviewEnabled,
  });

  @override
  List<Object?> get props => [
        isBasicDetailEnabled,
        isLinkEnabled,
        isProductEnabled,
        isReviewEnabled,
      ];
}

class LoadingState extends ProfilePrivacyState {
  @override
  List<Object> get props => [];
}