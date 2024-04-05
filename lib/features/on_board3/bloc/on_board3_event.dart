part of 'on_board3_bloc.dart';

abstract class OnBoard3Event extends Equatable {
  const OnBoard3Event();
}

class SocialLinkAdded extends OnBoard3Event {
  final SocialMedia socialMedia;
  final String link;
  final String label;

  const SocialLinkAdded(
      {required this.socialMedia, required this.link, required this.label});

  @override
  List<Object?> get props => [socialMedia, link, label];
}

class EditSocialLink extends OnBoard3Event {
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

class DeleteSocialLink extends OnBoard3Event {
  final SocialLink socialLink;

  DeleteSocialLink(this.socialLink);

  @override
  List<Object?> get props => [socialLink];

}
