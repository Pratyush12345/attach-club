import 'dart:developer';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupRepository {
  final CoreRepository _repository;

  SignupRepository(this._repository);

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    log("pre login");
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> sendOtp({
    required String phoneNumber,
    required int? resendToken,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) autoRetrieve,
    required void Function(PhoneAuthCredential) verificationCompleted,
  }) async {
    await _repository.sendOtp(
      phoneNumber: phoneNumber,
      resendToken: resendToken,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      autoRetrieve: autoRetrieve,
      verificationCompleted: verificationCompleted,
    );
  }

  Future<UserCredential> verifyOtp(
    String verificationId,
    String otp,
  ) async {
    return await _repository.verifyOtp(verificationId, otp);
  }
}
