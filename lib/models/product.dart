import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String title;
  final String description;
  final String price;
  final bool isShowEnquiryBtn;
  final File image;
  final Timestamp dateAdded;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.isShowEnquiryBtn,
    required this.image,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap(String imageUrl) {
    return {
      "title": title,
      "description": description,
      "price": price,
      "isShowEnquiryBtn": isShowEnquiryBtn,
      "image": imageUrl,
      "dateAdded": dateAdded,
    };
  }

  factory Product.fromMap({
    required Map<String, dynamic> map,
    required File image,
    required String docId,
  }) {
    return Product(
      title: map["title"],
      description: map["description"],
      price: map["price"],
      isShowEnquiryBtn: map["isShowEnquiryBtn"],
      image: image,
      dateAdded: map["dateAdded"],
    );
  }
}
