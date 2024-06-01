import 'dart:convert';
import 'dart:developer';

import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectionsRepository {
  final CoreRepository _repository;
  final Client _client;

  ConnectionsRepository(this._repository, this._client);

  Future<List<ConnectionRequest>> fetchConnections() async {
    //final domain = await _repository.getDomain();
    //final domain = GlobalVariable.metaData.apiURL;
    final list = <ConnectionRequest>[];
    final currentUser = _repository.getCurrentUser();
    // print("dmoan---$domain");
    // print(currentUser.uid);
    // final response = await _client.post(
    //   Uri.parse("$domain/getRequestsUserbyUid"),
    //   body: {"uid": currentUser.uid},
    // );
    // log(response.body);
    // if (response.statusCode != 200) {
    //   throw Exception("Failed to fetch connections");
    // }
    // final userData = jsonDecode(response.body);
    
    final db = FirebaseFirestore.instance;
    final data = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("requests")
        .get();
    
    List<String> ids = [];
    Map<String, Map<String, dynamic>> idmap = {};
    for (var i in data.docs) {
      if (i.exists) {
        final map = i.data();
        ids.add(i.id);
        idmap[i.id] =  map;
      }
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: ids)
        .get();
     
     for (var i in querySnapshot.docs){
      if(i.exists){
       list.add(ConnectionRequest.fromMap(
          connectionData: idmap[i.id]!,
          userData: UserData.fromMapDynamic(map: (i.data()! as Map), uid: i.id).toMap(),
          uid: i.id,
        ));
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
        .update({"status": CONNECTION_CONNECTED_STATUS});

    await db
        .collection("users")
        .doc(request.uid)
        .collection("requests")
        .doc(currentUser.uid)
        .update({"status": CONNECTION_CONNECTED_STATUS});
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

  Future<void> whatsappIconClicked(String phoneNo) async {
    await _repository.sendWhatsappMessage(phoneNo);
  }

  Future<void> phoneIconClicked(String phoneNo) async {
    final url = Uri.parse("tel:$phoneNo");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
