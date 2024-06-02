import 'package:flutter/foundation.dart';

class AppMetaData {
  String? apiURL;
  @required String? appBannerLink;
  String? appStoreLink;
  String? message;
  String? playStoreLink;
  String? version;
  String? webURL;

  AppMetaData(
      {this.apiURL,
      this.appBannerLink,
      this.appStoreLink,
      this.message,
      this.playStoreLink,
      this.version,
      this.webURL});

  AppMetaData.fromJson(Map<String, dynamic> json) {
    apiURL = json['apiURL'];
    appBannerLink = json['appBannerLink'];
    appStoreLink = json['appStoreLink'];
    message = json['message'];
    playStoreLink = json['playStoreLink'];
    version = json['version'];
    webURL = json['webURL'];
  }
  
  factory AppMetaData.fromMap(Map json) {
    return AppMetaData(
    apiURL : json['apiURL'],
    appBannerLink : json['appBannerLink'],
    appStoreLink : json['appStoreLink'],
    message : json['message'],
    playStoreLink : json['playStoreLink'],
    version : json['version'],
    webURL : json['webURL'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiURL'] = this.apiURL;
    data['appBannerLink'] = this.appBannerLink;
    data['appStoreLink'] = this.appStoreLink;
    data['message'] = this.message;
    data['playStoreLink'] = this.playStoreLink;
    data['version'] = this.version;
    data['webURL'] = this.webURL;
    return data;
  }
}
