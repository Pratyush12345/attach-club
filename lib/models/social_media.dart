class SocialMedia {
  final String imageUrl;
  final String name;

  SocialMedia({
    required this.imageUrl,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "name": name,
    };
  }

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
      imageUrl: map["imageUrl"],
      name: map["name"],
    );
  }
}
