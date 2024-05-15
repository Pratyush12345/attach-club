import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String title;
  final String description;
  final String price;
  final bool isShowEnquiryBtn;
  File? image;
  final Timestamp dateAdded;
  String imageUrl;
  final bool isEnabled;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.isShowEnquiryBtn,
    required this.image,
    required this.dateAdded,
    required this.imageUrl,
    required this.isEnabled,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "isShowEnquiryBtn": isShowEnquiryBtn,
      "image": imageUrl,
      "dateAdded": dateAdded,
      "isEnabled": isEnabled,
    };
  }

  factory Product.fromMap({
    required Map<String, dynamic> map,
    required File? image,
    required String docId,
  }) {
    return Product(
      title: map["title"],
      description: map["description"],
      price: map["price"],
      isShowEnquiryBtn: map["isShowEnquiryBtn"],
      image: image,
      dateAdded: map["dateAdded"],
      imageUrl: map["image"],
      isEnabled: map["isEnabled"],
    );
  }
}
