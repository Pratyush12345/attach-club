import 'dart:developer';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileRepository {
  final CoreRepository _repository;

  EditProfileRepository(this._repository);

  Future<UserData> getUserData() async {
    return await _repository.getUserData();
  }

  Future<void> updateName(String name) async {
    final currentUser = _repository.getCurrentUser();
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

  Future<void> updateNamedParam(String key, String value) async {
    final currentUser = await _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(currentUser.uid).update({
      key: value,
    });
  }

  Future<List<String>> getProfessions() async {
    final db = FirebaseFirestore.instance;
    final professions =
        await db.collection("constants").doc("professions").get();
    if(professions.exists){
      final data = professions.data();
      final List<String> list = [];
      for(var i in data!["professions"]){
        list.add(i.toString());
      }
      log(list.toString());
      return list;
    }
    return [];
  }
}
