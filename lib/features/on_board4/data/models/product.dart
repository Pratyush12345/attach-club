import 'dart:io';

class Product {
  final String title;
  final String description;
  final String price;
  final bool showEnquiry;
  final File image;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.showEnquiry,
    required this.image,
  });
}
