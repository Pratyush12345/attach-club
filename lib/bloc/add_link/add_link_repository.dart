import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return await _repository.getSocialLinks();
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

    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("links")
        .doc(socialLink.socialMedia.name)
        .delete();
  }
}
