import 'package:firebase_auth/firebase_auth.dart';

class SplashScreenRepository{
  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser!=null;
  }
}