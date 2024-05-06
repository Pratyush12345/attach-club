part of '../../../bloc/add_link/add_link_bloc.dart';

abstract class AddLinkEvent extends Equatable {
  const AddLinkEvent();
}

class SocialLinkAdded extends AddLinkEvent {
  final SocialMedia socialMedia;
  final String link;
  final String title;
  final List<SocialLink> list;
  final bool disabled;

  const SocialLinkAdded({
    required this.socialMedia,
    required this.link,
    required this.title,
    required this.list,
    required this.disabled,
  });

  @override
  List<Object?> get props => [socialMedia, link, title, disabled];
}

class EditSocialLink extends AddLinkEvent {
  final SocialLink oldSocialLink;
  final SocialMedia socialMedia;
  final String link;
  final String title;
  final bool disabled;

  const EditSocialLink({
    required this.oldSocialLink,
    required this.socialMedia,
    required this.link,
    required this.title,
    required this.disabled,
  });

  @override
  List<Object?> get props => [oldSocialLink, socialMedia, link, title, disabled];
}

class DeleteSocialLink extends AddLinkEvent {
  final SocialLink socialLink;

  const DeleteSocialLink(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}

class UploadSocialLink extends AddLinkEvent {
  final List<SocialLink> list;

  const UploadSocialLink(this.list);

  @override
  List<Object?> get props => [list];
}

class FetchSocialLinks extends AddLinkEvent {
  @override
  List<Object?> get props => [];
}
