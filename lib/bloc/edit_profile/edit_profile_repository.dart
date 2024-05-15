import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class EditProfileRepository {

  final CoreRepository _repository;

  EditProfileRepository(this._repository);

  Future<UserData> getUserData()async {
    return await _repository.getUserData();
  }

  Future<void> updateName(String name) async {
    final currentUser = await _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(currentUser.uid).update({
      "name": name,
    });
  }

  Future<void> updateProfession(String profession) async {
    final currentUser = await _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(currentUser.uid).update({
      "profession": profession,
    });
  }

  Future<void> updateDescription(String description) async {
    final currentUser = await _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(currentUser.uid).update({
      "description": description,
    });
  }
}