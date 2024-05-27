import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupRepository {
  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

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
    final auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
      forceResendingToken: resendToken
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
    return await auth.signInWithCredential(credential);
  }

}
