import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CompleteProfileRepository {

  final CoreRepository _repository;

  CompleteProfileRepository(this._repository);
  
  Future<bool> isUsernameAvailable(String username)async{
    final db = FirebaseDatabase.instance;
    final ref = db.ref("usernames/$username");
    final currentUser = _repository.getCurrentUser();
    final data = await ref.get();
    if(data.exists && data.value != null && data.value!=currentUser.uid){
      return false;
    }
    return true;
  }
  
  Future<void> uploadUserData(UserData userData)async{
    final user = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(user.uid).set(userData.toMap());
  }

  Future<void> uploadUserToRealtime(UserData user) async {
    final db = FirebaseDatabase.instance;
    final currentUser = _repository.getCurrentUser();
    final ref = db.ref("usernames/${user.username}");
    await ref.set(currentUser.uid);

    final userRef = db.ref("users/${currentUser.uid}");
    await userRef.set({
      "name": user.name,
      "phoneNo": user.phoneNo,
      "profession": user.profession,
    });
  }

  Future<UserData> getUserData()async {
    return await _repository.getUserData();
  }
}