import 'dart:developer';

import 'package:attach_club/models/greeting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GreetingTopic {
  final String categoryDescription;
  final String categoryName;
  final Timestamp creationTime;
  final List<Greeting> templates;

  GreetingTopic({
    required this.categoryDescription,
    required this.categoryName,
    required this.creationTime,
    required this.templates,
  });

  factory GreetingTopic.fromMap(
    Map<String, dynamic> map,
    QuerySnapshot<Map<String, dynamic>> greetingMap,
  ) {
    log(map["categoryName"]);
    return GreetingTopic(
      categoryDescription: map['categoryDescription'],
      categoryName: map['categoryName'],
      creationTime: map['creationTime'],
      templates: greetingMap.docs
          .map((greeting) => Greeting.fromMap(greeting.data()))
          .toList(),
    );
  }
}
