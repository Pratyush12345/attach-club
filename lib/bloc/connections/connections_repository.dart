import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnectionsRepository {
  final CoreRepository _repository;

  ConnectionsRepository(this._repository);

  Future<List<ConnectionRequest>> fetchConnections() async {
    final list = <ConnectionRequest>[];
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("requests")
        .get();

    for (var i in data.docs) {
      if (i.exists) {
        final map = i.data();
        list.add(ConnectionRequest.fromMap(map, i.id));
      }
    }
    return list;
  }

  Future<void> acceptRequest(ConnectionRequest request) async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("requests")
        .doc(request.uid)
        .update({"status": "Connected"});


    await db
        .collection("users")
        .doc(request.uid)
        .collection("requests")
        .doc(currentUser.uid)
        .update({"status": "Connected"});
  }

  Future<void> rejectRequest(ConnectionRequest request) async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("requests")
        .doc(request.uid)
        .delete();

    await db
        .collection("users")
        .doc(request.uid)
        .collection("requests")
        .doc(currentUser.uid)
        .delete();
  }
}
