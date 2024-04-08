import 'package:attach_club/models/social_media.dart';

class SocialLink {
  final String label;
  final SocialMedia socialMedia;
  final String link;

  SocialLink({
    required this.label,
    required this.socialMedia,
    required this.link,
  });
}
