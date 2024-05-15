part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class GoogleLoginTriggered extends SignupEvent {
  @override
  List<Object?> get props => [];
}

class PhoneVerificationTriggered extends SignupEvent {
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

class VerifyOtp extends SignupEvent {
  final String otp;

  const VerifyOtp({
    required this.otp,
  });

  @override
  List<Object?> get props => [otp];
}

class CheckOnboardingStatus extends SignupEvent {
  @override
  List<Object?> get props => [];
}