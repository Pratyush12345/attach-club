import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailedAnalyticsRepository {
  final CoreRepository _repository;

  DetailedAnalyticsRepository(this._repository);

  Future<int> getConnections() async {
    final user = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data =
        await db.collection("users").doc(user.uid).collection("requests").get();

    return data.docs
        .where((element) =>
            element.data()["status"] == CONNECTION_CONNECTED_STATUS)
        .length;
  }

  Future<List<Review>> getReviews() async {
    return await _repository.getReviewsList(null);
  }

  Future<void> deleteReview(String id) async {
    final db = FirebaseFirestore.instance;
    final user = _repository.getCurrentUser();
    await db
        .collection("users")
        .doc(user.uid)
        .collection("review")
        .doc(id)
        .delete();
  }
}
