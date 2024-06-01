import 'dart:convert';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/metaData.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart';

class DashboardRepository {
  final CoreRepository _coreRepository;
  final Client _client;

  DashboardRepository(this._coreRepository, this._client);

  Future<int> getConnectionsCount() async {
    final user = _coreRepository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final docs =
        await db.collection("users").doc(user.uid).collection("requests").get();
    int count = 0;
    for (var i in docs.docs) {
      if (i.exists && i.data()["status"] == CONNECTION_CONNECTED_STATUS) {
        count++;
      }
    }
    return count;
  }

  Future<int> getReviewCount() async {
    final user = _coreRepository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final reviewDocs =
        await db.collection("users").doc(user.uid).collection("review").get();
    return reviewDocs.size;
  }

  Future<void> sendWhatsappMessage(String phoneNo) async {
    _coreRepository.sendWhatsappMessage(phoneNo);
  }
 
  Future<AppMetaData> getMetaData() async {
    final db = FirebaseDatabase.instance;
    final data = await db.ref("MetaData").get();
    if (data.exists) {
      return AppMetaData.fromMap(data.value as Map);
    }
    throw Exception("Meta data not found");
  }
  
  Future<List<UserData>> getSuggestedProfile(UserData userData) async {
    // return [];
    final domain = await _coreRepository.getDomain();

    final response = await _client.get(
      Uri.parse(
        "$domain/getSuggestedProfile?"
        "profession=${userData.profession}"
        "&accountType=${userData.accountType}"
        "&uid=${userData.uid}"
        "&city=${userData.city}",
      ),
    );
    if (response.statusCode == 200) {
      final List<UserData> list = [];
      final Map<String, dynamic> map = jsonDecode(response.body);
      for (var i in map.entries) {
        list.add(UserData.fromJson(
          map: (i.value as Map<String, dynamic>),
          uid: i.key,
        ));
      }
      return list;
    }
    throw Exception("Error fetching suggested profile");
  }
}
