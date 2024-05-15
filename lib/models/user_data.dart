import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String accountType;
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
  bool isProductEnabled;
  bool isReviewEnabled;
  Timestamp lastLoginDate;
  Timestamp lastPaymentDate;
  String logoImageURL;
  String name;
  String phoneNo;
  String pin;
  String profession;
  int profileClickCount;
  String profileImageURL;
  String purchasedPlanCode;
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
    this.profileImageURL = "",
    this.purchasedPlanCode = "",
    this.state = "",
    required this.username,
    this.isActive = true,
    this.isBasicDetailEnabled = true,
    this.isEverPurchasedPremium = true,
    this.isLinkEnabled = true,
    this.isOnline = true,
    this.isProductEnabled = true,
    this.isReviewEnabled = true,
    this.uid,
  });

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
      "lastPaymentDate": lastPaymentDate,
      "logoImageURL": logoImageURL,
      "name": name,
      "phoneNo": phoneNo,
      "pin": pin,
      "profession": profession,
      "profileClickCount": profileClickCount,
      "profileImageURL": profileImageURL,
      "purchasedPlanCode": purchasedPlanCode,
      "state": state,
      "username": username,
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
      lastLoginDate: map["lastLoginDate"],
      lastPaymentDate: map["lastPaymentDate"],
      logoImageURL: map["logoImageURL"],
      name: map["name"],
      phoneNo: map["phoneNo"],
      pin: map["pin"],
      profession: map["profession"],
      profileClickCount: map["profileClickCount"],
      profileImageURL: map["profileImageURL"],
      purchasedPlanCode: map["purchasedPlanCode"],
      state: map["state"],
      username: map["username"],
      uid: uid,
    );
  }

  factory UserData.fromJson({required Map<String, dynamic> map, String? uid}) {
    log(uid.toString());
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
      purchasedPlanCode: map["purchasedPlanCode"],
      state: map["state"],
      username: map["username"],
      uid: uid,
    );
  }
}
