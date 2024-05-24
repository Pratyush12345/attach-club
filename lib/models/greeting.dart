import 'package:cloud_firestore/cloud_firestore.dart';

class Greeting {
  final Timestamp creationTime;
  final String link;
  final String name;

  Greeting({
    required this.creationTime,
    required this.link,
    required this.name,
  });

  factory Greeting.fromMap(Map<String, dynamic> map) {
    return Greeting(
      creationTime: map['creationTime'],
      link: map['link'],
      name: map['name'],
    );
  }
}
