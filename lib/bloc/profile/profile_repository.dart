import 'dart:developer';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:attach_club/models/review.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final CoreRepository _repository;

  ProfileRepository(this._repository);

  Future<UserData> getUserData(String? uid) async {
    if (uid == null) {
      return await _repository.getUserData();
    } else {
      return await _repository.getUserDataFromUid(uid);
    }
  }

  Future<List<SocialLink>> getSocialLinksList(String? uid) async {
    if (uid == null) {
      return await _repository.getSocialLinks();
    }
    return await _repository.getSocialLinksFromUid(uid);
  }

  Future<List<Product>> getAllProducts(String? uid) async {
    if (uid == null) {
      return await _repository.getAllProducts();
    }
    return await _repository.getAllProductsFromUid(uid);
  }

  Future<void> downloadImageOfProducts({
    required List<Product> list,
    required void Function(List<Product>) onListUpdated,
    String? uid,
  }) async {
    return await _repository.downloadImageOfProducts(
      list: list,
      onListUpdated: onListUpdated,
      uid: uid,
    );
  }

  Future<void> querywhatsappIconClicked(String phoneNo) async {
    await _repository.sendQueryWhatsappMessage(phoneNo);
  }

  Future<void> addReview(Review review, String profileUid) async {
    final user = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(profileUid)
        .collection("review")
        .doc(user.uid)
        .set(review.toJson());
  }

  Future<List<Review>> getReviewsList(String? uid) async {
    return await _repository.getReviewsList(uid);
  }

  Future<void> incrementViewCount(String uid) async {
    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(uid).get();
    if (data.exists) {
      final count = UserData.fromMap(map: data.data()!).profileViewCount;
      await db.collection("users").doc(uid).update({
        "profileViewCount": count + 1,
      });
    }
  }

  Future<void> incrementClickCount() async {
    final uid = _repository.getCurrentUser().uid;
    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(uid).get();
    if (data.exists) {
      final count = UserData.fromMap(map: data.data()!).profileClickCount;
      await db.collection("users").doc(uid).update({
        "profileClickCount": count + 1,
      });
      final prefs = await SharedPreferences.getInstance();
      final DateTime date = DateTime.parse(
          prefs.getString('counterDate') ?? DateTime.now().toString());
      if(date.difference(DateTime.now()) < const Duration(days: 1)){
        log("increment");
        final int localCount = prefs.getInt('counter')??0;
        await prefs.setInt('counter', localCount+1);
      }else{
        log("reset");
        await prefs.setInt('counter', 1);
        await prefs.setString('counterDate', DateTime.now().toString());
      }

    }
  }

  Future<void> sendConnectionRequest(String userUid) async {
    await _repository.sendConnectionRequest(userUid);
  }
}
