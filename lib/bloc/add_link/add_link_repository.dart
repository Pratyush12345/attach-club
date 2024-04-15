import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddLinkRepository {
  final CoreRepository _repository;

  AddLinkRepository(this._repository);

  Future<void> uploadSocialLinks(List<SocialLink> list) async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;

    final ref = db.collection("users").doc(currentUser.uid).collection("links");

    for (var i in list) {
      ref.doc(i.socialMedia.name).set(i.toMap());
    }
  }

  Future<List<SocialLink>> getSocialLinks() async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final list = <SocialLink>[];
    final data = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("links")
        .get();

    for (var i in data.docs) {
      list.add(SocialLink.fromMap(i.data()));
    }

    return list;
  }

  Future<void> addToList(SocialLink socialLink) async {
    final currentUser = _repository.getCurrentUser();

    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("links")
        .doc(socialLink.socialMedia.name)
        .set(socialLink.toMap());
  }

  Future<void> deleteSocialLink(SocialLink socialLink) async {
    final currentUser = _repository.getCurrentUser();
    if (currentUser == null) {
      throw Exception("User is not logged in");
    }

    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("links")
        .doc(socialLink.socialMedia.name)
        .delete();
  }
}
