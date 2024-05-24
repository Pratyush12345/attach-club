import 'dart:developer';

import 'package:attach_club/models/greeting_topic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GreetingsRepository {
  Future<List<GreetingTopic>> fetchGreetings() async {
    final db = FirebaseFirestore.instance;
    final topicList = await db.collection('socialGreetings').get();
    final List<GreetingTopic> list = [];
    
    topicList.docs.map((e) => e.data() );

    for(var greetingTopic in topicList.docs) {
      final greeting = await db.collection('socialGreetings').doc(greetingTopic.id).collection('templates').get();
      list.add(GreetingTopic.fromMap(greetingTopic.data(), greeting));
    }
    return list;
  }

}