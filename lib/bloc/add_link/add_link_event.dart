part of '../../../bloc/add_link/add_link_bloc.dart';


abstract class AddLinkEvent extends Equatable {
  const AddLinkEvent();
}

class SocialLinkAdded extends AddLinkEvent {
  final SocialMedia socialMedia;
  final String link;
  final String label;

  const SocialLinkAdded(
      {required this.socialMedia, required this.link, required this.label});

  @override
  List<Object?> get props => [socialMedia, link, label];
}

class EditSocialLink extends AddLinkEvent {
  final SocialLink oldSocialLink;
  final SocialMedia socialMedia;
  final String link;
  final String label;

  const EditSocialLink({
    required this.oldSocialLink,
    required this.socialMedia,
    required this.link,
    required this.label,
  });

  @override
  List<Object?> get props => [oldSocialLink, socialMedia, link, label];
}

class DeleteSocialLink extends AddLinkEvent {
  final SocialLink socialLink;

  DeleteSocialLink(this.socialLink);

  @override
  List<Object?> get props => [socialLink];

}
