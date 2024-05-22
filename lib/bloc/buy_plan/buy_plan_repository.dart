import 'dart:convert';
import 'dart:developer';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/plan.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart';

class BuyPlanRepository {
  final CoreRepository _coreRepository;
  final Client _client;

  BuyPlanRepository(
    this._coreRepository,
    this._client,
  );

  Future<List<Plan>> buyPlan() async {
    final db = FirebaseDatabase.instance;
    final data = await db.ref("PaymentPlan").get();
    if (data.exists && data.value is Map) {
      final list = data.children.map((e) => Plan.fromSnapshot(e)).toList();
      return list
          .where((element) => element.isVisible && element.planPrice != 0)
          .toList();
    }
    return [];
  }

  Future<String> placeOrder() async {
    final currentUser = _coreRepository.getCurrentUser();
    final uid = currentUser.uid;
    log(uid);
    final response = await _client.post(
      Uri.parse(
        "https://us-central1-attach-club.cloudfunctions.net/createOrder?userid=$uid",
      ),
      body: jsonEncode(
        {
          "order": {
            "planCode": "60DP",
          }
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 201) {
      return response.body;
    }
    log("error occurred in post call ${response.body}");
    throw Exception("Error placing order");
  }

  Future<bool> verifyPayment(String orderId) async {
    final response = await _client.get(
      Uri.parse(
        "https://us-central1-attach-club.cloudfunctions.net/verifyPayment?id=$orderId",
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = jsonDecode(response.body);
      log(map["message"]["order_status"]);
      return map["message"]["order_status"] == "PAID";
    }
    throw Exception("Error verifying payment");
  }

  Future<UserData> getUserData() async {
    return await _coreRepository.getUserData();
  }
}
