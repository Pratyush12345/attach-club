import 'package:attach_club/models/social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

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

const double paddingDueToNav = 30;

const primaryTextColor = Colors.white;
final secondaryTextColor = Colors.white.withOpacity(0.7);
final paragraphTextColor = Colors.white.withOpacity(0.5);

const CONNECTION_RECEIVED_STATUS = "Received";
const CONNECTION_SENT_STATUS = "Sent";
const CONNECTION_CONNECTED_STATUS = "Connected";

const SEARCH_PAGE = "Search";
const PROFILE_PAGE = "Profile";
const QR_PAGE = "QR";


const lorem = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary,";
const CFEnvironment cfEnvironment = CFEnvironment.SANDBOX;
final theme = CFThemeBuilder()
    .setNavigationBarBackgroundColorColor("#FF0000")
    .setPrimaryFont("Menlo")
    .setSecondaryFont("Futura")
    .build();