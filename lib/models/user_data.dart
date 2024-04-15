class UserData {
  String accountType;
  int age;
  String bannerImageURL;
  String city;
  String country;
  String description;
  String email;
  String firstLoginDate;
  String headLineTxt;
  bool isActive;
  bool isBasicDetailEnabled;
  bool isEverPurchasedPremium;
  bool isLinkEnabled;
  bool isOnline;
  bool isProductEnabled;
  bool isReviewEnabled;
  String lastLoginDate;
  String lastPaymentDate;
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

  UserData({
    this.accountType = "normal",
    this.age = 0,
    this.bannerImageURL = "",
    this.city = "",
    this.country = "",
    this.description = "",
    this.email = "",
    this.firstLoginDate = "",
    this.headLineTxt = "",
    this.lastLoginDate = "",
    this.lastPaymentDate = "",
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

  factory UserData.fromMap(Map<String, dynamic> map){
    return UserData(accountType: map["accountType"],
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
    );
  }
}
