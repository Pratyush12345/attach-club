import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:attach_club/models/review.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> incrementProfileCount(String uid) async {
    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(uid).get();
    if (data.exists) {
      final count = UserData.fromMap(map: data.data()!).profileClickCount;
      await db.collection("users").doc(uid).update({
        "profileClickCount": count + 1,
      });
    }
  }

  Future<void> sendConnectionRequest(String userUid) async {
    await _repository.sendConnectionRequest(userUid);
  }
}
