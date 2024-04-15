import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoreRepository{
  Future<bool> checkOnboardingStatus() async {
    final db = FirebaseFirestore.instance;
    final currentUser = getCurrentUser();
    final data = await db.collection("users").doc(currentUser.uid).get();
    if(data.exists && data.data()!=null && data.data()!["isActive"]==true){
      return true;
    }
    return false;
  }

  Future<UserData> getUserData() async {
    final currentUser = getCurrentUser();
    final db = FirebaseFirestore.instance;
    final data =  await db.collection("users").doc(currentUser.uid).get();
    if(data.exists){
      return UserData.fromMap(data.data()!);
    }
    throw Exception("User data not found");
  }

  User getCurrentUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser==null){
      throw Exception("User not logged in");
    }
    return currentUser;
  }

}