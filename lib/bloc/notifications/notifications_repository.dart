import 'package:attach_club/core/repository/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/notification_data.dart';

class NotificationsRepository {
  final CoreRepository _repository;

  NotificationsRepository(this._repository);

  Future<List<NotificationData>> getPublicAlerts() async {
    final List<NotificationData> list = [];
    final db = FirebaseFirestore.instance;

    final data = await db.collection("publicAlerts").get();
    for (var i in data.docs) {
      if (i.exists) {
        list.add(NotificationData.fromMap(i.data()));
      }
    }

    return list;
  }

  Future<List<NotificationData>> getPrivateAlerts() async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(currentUser.uid)
        .collection("Alerts")
        .get();
    final List<NotificationData> list = [];
    for (var i in data.docs){
      if(i.exists){
        list.add(NotificationData.fromMap(i.data()));
      }
    }
    return list;
  }
}
