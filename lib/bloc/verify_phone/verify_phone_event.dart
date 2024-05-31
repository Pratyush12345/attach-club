part of 'verify_phone_bloc.dart';

sealed class VerifyPhoneEvent extends Equatable {
  const VerifyPhoneEvent();
}

class PhoneVerificationTriggered extends VerifyPhoneEvent {
  final String phoneNumber;
  final void Function(FirebaseAuthException) verificationFailed;
  final void Function(PhoneAuthCredential) verificationCompleted;

  const PhoneVerificationTriggered({
    required this.phoneNumber,
    required this.verificationFailed,
    required this.verificationCompleted,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtp extends VerifyPhoneEvent {
  final String otp;

  const VerifyOtp({
    required this.otp,
  });

  @override
  List<Object?> get props => [otp];
}

class CheckOnboardingStatus extends VerifyPhoneEvent {
  @override
  List<Object?> get props => [];
}
