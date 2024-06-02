import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserDataNotifier extends ChangeNotifier{
  UserData _userData = UserData(
    username: "",
    firstLoginDate: Timestamp.now(),
    lastLoginDate: Timestamp.now(),
    lastPaymentDate: Timestamp.now(),
    isPlanExpiredRecently: false,
    planExitDate: Timestamp.now(),
    planPurchaseDate: Timestamp.now(),
  );
  UserData get userData => _userData;
  void updateUserData(UserData newUserData){
    _userData = newUserData;
    notifyListeners();
  }
}