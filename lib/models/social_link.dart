import 'package:attach_club/models/social_media.dart';

class SocialLink {
  final String title;
  final SocialMedia socialMedia;
  final String link;
  final bool isEnabled;

  SocialLink({
    required this.title,
    required this.socialMedia,
    required this.link,
    required this.isEnabled,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "socialMedia": socialMedia.toMap(),
      "link": link,
      "isEnabled": isEnabled,
    };
  }

  factory SocialLink.fromMap(Map<String, dynamic> map) {
    return SocialLink(
      title: map["title"],
      socialMedia: SocialMedia.fromMap(map["socialMedia"]),
      link: map["link"],
      isEnabled: map["isEnabled"],
    );
  }
}
