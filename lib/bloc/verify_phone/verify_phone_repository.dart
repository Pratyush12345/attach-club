import 'package:firebase_auth/firebase_auth.dart';

import '../../core/repository/core_repository.dart';

class VerifyPhoneRepository {
  final CoreRepository _repository;

  VerifyPhoneRepository(this._repository);

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
    final auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    final creds =  await auth.currentUser!.linkWithCredential(credential);
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser!=null && currentUser.phoneNumber!=null){
      await _repository.updatePhoneNo(currentUser.phoneNumber!);
    }
    return creds;
  }

  Future<bool> checkOnboardingStatus() async {
    return await _repository.checkOnboardingStatus();
  }
}
