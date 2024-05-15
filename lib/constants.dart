import 'package:attach_club/models/social_media.dart';
import 'package:flutter/material.dart';

const horizontalPadding = 24.0;

const onboardingButtonBottomPadding = 12.0;

final socialMediaList = <SocialMedia>[
  SocialMedia(imageUrl: "assets/svg/whatsapp.svg", name: "Whatsapp"),
  SocialMedia(imageUrl: "assets/svg/facebook.svg", name: "Facebook"),
  SocialMedia(imageUrl: "assets/svg/youtube.svg", name: "Youtube"),
  SocialMedia(imageUrl: "assets/svg/twitter.svg", name: "Twitter"),
  SocialMedia(imageUrl: "assets/svg/tiktok.svg", name: "TikTok"),
  SocialMedia(imageUrl: "assets/svg/instagram.svg", name: "Instagram"),
  SocialMedia(imageUrl: "assets/svg/snapchat.svg", name: "Snapchat"),
];

const double paddingDueToNav = 110;

const primaryTextColor = Colors.white;
final secondaryTextColor = Colors.white.withOpacity(0.7);
final paragraphTextColor = Colors.white.withOpacity(0.5);

const lorem = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary,";