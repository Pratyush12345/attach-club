import 'package:attach_club/models/user_data.dart';
import 'package:flutter/foundation.dart';

class UserDataNotifier extends ChangeNotifier{
  UserData _userData = UserData(username: '');
  UserData get userData => _userData;
  void updateUserData(UserData newUserData){
    _userData = newUserData;
    notifyListeners();
  }
}