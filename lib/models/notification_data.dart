import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationData {
  final String title;
  final String body;
  final String type;
  final Timestamp creationDate;

  NotificationData({
    required this.title,
    required this.body,
    required this.creationDate,
    required this.type,
  });

  factory NotificationData.fromMap(Map<String, dynamic> map){
    return NotificationData(
      title: map['title'],
      body: map['body'],
      creationDate: map['creationDate'],
      type: map['type'],
    );
  }
}
