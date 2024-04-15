import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CompleteProfileRepository {

  final CoreRepository _repository;

  CompleteProfileRepository(this._repository);
  
  Future<bool> isUsernameAvailable(String username)async{
    final db = FirebaseDatabase.instance;
    final ref = db.ref("usernames/$username");
    final data = await ref.get();
    if(data.exists){
      return false;
    }
    return true;
  }
  
  Future<void> uploadUserData(UserData userData)async{
    final user = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(user.uid).set(userData.toMap());
  }

  Future<UserData> getUserData()async {
    return await _repository.getUserData();
  }
}