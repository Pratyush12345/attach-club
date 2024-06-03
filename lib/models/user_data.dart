import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String accountType;
  String andrTokenid;
  String iosTokenid;
  int age;
  String bannerImageURL;
  String city;
  String country;
  String description;
  String email;
  Timestamp firstLoginDate;
  String headLineTxt;
  bool isActive;
  bool isBasicDetailEnabled;
  bool isEverPurchasedPremium;
  bool isLinkEnabled;
  bool isOnline;
  bool isPlanExpiredRecently;
  bool isProductEnabled;
  bool isReviewEnabled;
  bool isShowProfileImageOnGreeting;
  Timestamp lastLoginDate;
  Timestamp lastPaymentDate;
  String logoImageURL;
  String name;
  String phoneNo;
  String pin;
  Timestamp planExitDate;
  Timestamp planPurchaseDate;
  String profession;
  int profileClickCount;
  String profileImageURL;
  int profileViewCount;
  String purchasedPlanCode;
  int rating;
  String state;
  String username;
  String? uid;

  UserData({
    this.accountType = "normal",
    this.age = 0,
    this.bannerImageURL = "",
    this.city = "",
    this.country = "",
    this.description = "",
    this.email = "",
    required this.firstLoginDate,
    this.headLineTxt = "",
    required this.lastLoginDate,
    required this.lastPaymentDate,
    this.logoImageURL = "",
    this.name = "",
    this.phoneNo = "",
    this.pin = "",
    this.profession = "",
    this.profileClickCount = 0,
    this.profileViewCount = 0,
    this.rating = 0,
    this.profileImageURL = "",
    this.purchasedPlanCode = "",
    this.state = "",
    required this.username,
    this.isActive = true,
    this.isBasicDetailEnabled = true,
    this.isEverPurchasedPremium = false,
    this.isLinkEnabled = true,
    this.isOnline = true,
    required this.isPlanExpiredRecently,
    required this.planExitDate,
    required this.planPurchaseDate,
    this.isProductEnabled = true,
    this.isReviewEnabled = true,
    this.isShowProfileImageOnGreeting = true,
    this.andrTokenid = "",
    this.iosTokenid = "",
    this.uid,
  });
  
   // Override the == operator and hashCode for comparison based on ID
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserData &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;

  Map<String, dynamic> toMap() {
    return {
      "accountType": accountType,
      "age": age,
      "bannerImageURL": bannerImageURL,
      "city": city,
      "country": country,
      "description": description,
      "email": email,
      "firstLoginDate": firstLoginDate,
      "headLineTxt": headLineTxt,
      "isActive": isActive,
      "isBasicDetailEnabled": isBasicDetailEnabled,
      "isEverPurchasedPremium": isEverPurchasedPremium,
      "isLinkEnabled": isLinkEnabled,
      "isOnline": isOnline,
      "isProductEnabled": isProductEnabled,
      "isReviewEnabled": isReviewEnabled,
      "lastLoginDate": lastLoginDate,
      "isShowProfileImageOnGreeting": isShowProfileImageOnGreeting,
      "lastPaymentDate": lastPaymentDate,
      "logoImageURL": logoImageURL,
      "name": name,
      "phoneNo": phoneNo,
      "pin": pin,
      "profession": profession,
      "profileClickCount": profileClickCount,
      "profileViewCount": profileViewCount,
      "rating": rating,
      "profileImageURL": profileImageURL,
      "purchasedPlanCode": purchasedPlanCode,
      "state": state,
      "username": username,
      "andrTokenid": andrTokenid,
      "iosTokenid": iosTokenid,
    };
  }

  factory UserData.fromMap({
    required Map<String, dynamic> map,
    String? uid,
  }) {
    return UserData(
      accountType: map["accountType"],
      age: map["age"],
      bannerImageURL: map["bannerImageURL"],
      city: map["city"],
      country: map["country"],
      description: map["description"],
      email: map["email"],
      firstLoginDate: map["firstLoginDate"],
      headLineTxt: map["headLineTxt"],
      isActive: map["isActive"],
      isBasicDetailEnabled: map["isBasicDetailEnabled"],
      isEverPurchasedPremium: map["isEverPurchasedPremium"],
      isLinkEnabled: map["isLinkEnabled"],
      isOnline: map["isOnline"],
      isProductEnabled: map["isProductEnabled"],
      isReviewEnabled: map["isReviewEnabled"],
      isShowProfileImageOnGreeting: map["isShowProfileImageOnGreeting"],
      lastLoginDate: map["lastLoginDate"],
      lastPaymentDate: map["lastPaymentDate"],
      logoImageURL: map["logoImageURL"],
      name: map["name"],
      phoneNo: map["phoneNo"],
      pin: map["pin"],
      profession: map["profession"],
      profileClickCount: map["profileClickCount"],
      profileViewCount: map["profileViewCount"],
      rating: map["rating"],
      profileImageURL: map["profileImageURL"],
      purchasedPlanCode: map["purchasedPlanCode"],
      state: map["state"],
      username: map["username"],
      andrTokenid: map["andrTokenId"] ?? "",
      iosTokenid: map["iosTokenId"] ?? "",
      uid: uid,
      isPlanExpiredRecently: map["isPlanExpiredRecently"] ?? false,
      planExitDate: map["planExitDate"] ?? Timestamp.now(),
      planPurchaseDate: map["planPurchaseDate"] ?? Timestamp.now(),
    );
  }

  factory UserData.fromMapDynamic({
    required Map<dynamic, dynamic> map,
    String? uid,
  }) {
    return UserData(
      accountType: map["accountType"],
      age: map["age"],
      bannerImageURL: map["bannerImageURL"],
      city: map["city"],
      country: map["country"],
      description: map["description"],
      email: map["email"],
      firstLoginDate: map["firstLoginDate"],
      headLineTxt: map["headLineTxt"],
      isActive: map["isActive"],
      isBasicDetailEnabled: map["isBasicDetailEnabled"],
      isEverPurchasedPremium: map["isEverPurchasedPremium"],
      isLinkEnabled: map["isLinkEnabled"],
      isOnline: map["isOnline"],
      isProductEnabled: map["isProductEnabled"],
      isReviewEnabled: map["isReviewEnabled"],
      isShowProfileImageOnGreeting : map["isShowProfileImageOnGreeting"],
      lastLoginDate: map["lastLoginDate"],
      lastPaymentDate: map["lastPaymentDate"],
      logoImageURL: map["logoImageURL"],
      name: map["name"],
      phoneNo: map["phoneNo"],
      pin: map["pin"],
      profession: map["profession"],
      profileClickCount: map["profileClickCount"],
      profileViewCount: map["profileViewCount"],
      rating: map["rating"],
      profileImageURL: map["profileImageURL"],
      purchasedPlanCode: map["purchasedPlanCode"],
      state: map["state"],
      username: map["username"],
      andrTokenid: map["andrTokenId"] ?? "",
      iosTokenid: map["iosTokenId"] ?? "",
      uid: uid,
      isPlanExpiredRecently: map["isPlanExpiredRecently"] ?? false,
      planExitDate: map["planExitDate"] ?? Timestamp.now(),
      planPurchaseDate: map["planPurchaseDate"] ?? Timestamp.now(),
    );
  }

  factory UserData.fromJson({required Map<String, dynamic> map, String? uid}) {
    return UserData(
      accountType: map["accountType"],
      age: map["age"],
      bannerImageURL: map["bannerImageURL"],
      city: map["city"],
      country: map["country"],
      description: map["description"],
      email: map["email"],
      firstLoginDate: Timestamp(
        map["firstLoginDate"]["_seconds"],
        map["firstLoginDate"]["_nanoseconds"],
      ),
      headLineTxt: map["headLineTxt"],
      isActive: map["isActive"],
      isBasicDetailEnabled: map["isBasicDetailEnabled"],
      isEverPurchasedPremium: map["isEverPurchasedPremium"],
      isLinkEnabled: map["isLinkEnabled"],
      isOnline: map["isOnline"],
      isProductEnabled: map["isProductEnabled"],
      isReviewEnabled: map["isReviewEnabled"],
      lastLoginDate: Timestamp(
        map["lastLoginDate"]["_seconds"],
        map["lastLoginDate"]["_nanoseconds"],
      ),
      //TODO: Not receiving this from API
      // lastPaymentDate: Timestamp(
      //   map["lastPaymentDate"]["_seconds"],
      //   map["lastPaymentDate"]["_nanoseconds"],
      // ),
      lastPaymentDate: Timestamp.now(),
      //TODO: Remove this line
      logoImageURL: map["logoImageURL"],
      name: map["name"],
      phoneNo: map["phoneNo"],
      pin: map["pin"],
      profession: map["profession"],
      profileClickCount: map["profileClickCount"],
      profileImageURL: map["profileImageURL"],
      rating: map["rating"],
      purchasedPlanCode: map["purchasedPlanCode"],
      state: map["state"],
      username: map["username"],
      uid: uid,
      andrTokenid: map["andrTokenId"] ?? "",
      iosTokenid: map["iosTokenId"] ?? "",
      isPlanExpiredRecently: map["isPlanExpiredRecently"] ?? false,
      planExitDate: Timestamp(
        map["planExitDate"]["_seconds"],
        map["planExitDate"]["_nanoseconds"],
      ),
      planPurchaseDate: Timestamp(
        map["planPurchaseDate"]["_seconds"],
        map["planPurchaseDate"]["_nanoseconds"],
      ),
    );
  }
}
