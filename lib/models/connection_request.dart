import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectionRequest {
  final String phoneNo;
  final String status;
  final Timestamp updateTime;
  final String uid;
  final String name;
  final String url;
  final String profession;

  ConnectionRequest({
    required this.phoneNo,
    required this.status,
    required this.updateTime,
    required this.uid,
    this.url = "",
    this.name = "",
    this.profession = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "phoneNo": phoneNo,
      "status": status,
      "updateTime": updateTime,
    };
  }

  factory ConnectionRequest.fromMap({
    required Map<String, dynamic> connectionData,
    required String uid,
    required Map<String, dynamic> userData,
  }) {
    return ConnectionRequest(
      url : userData["profileImageURL"],
      phoneNo: userData["phoneNo"],
      status: connectionData["status"],
      updateTime: connectionData["updateTime"],
      uid: uid,
      name: userData["name"],
      profession: userData["profession"],
    );
  }
}
