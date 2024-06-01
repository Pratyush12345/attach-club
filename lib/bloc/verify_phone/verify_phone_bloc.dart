import 'dart:developer';

import 'package:attach_club/bloc/verify_phone/verify_phone_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_phone_event.dart';
part 'verify_phone_state.dart';

class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent, VerifyPhoneState> {
  final VerifyPhoneRepository _repository;
  String verificationId = "";
  int? resendToken;

  VerifyPhoneBloc(this._repository) : super(VerifyPhoneInitial()) {
    on<PhoneVerificationTriggered>((event, emit) async {
      try {
        await _repository.sendOtp(
            phoneNumber: event.phoneNumber,
            verificationFailed: event.verificationFailed,
            codeSent: _codeSent,
            verificationCompleted: event.verificationCompleted,
            resendToken: resendToken,
            autoRetrieve: _autoRetrieve
        );
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<VerifyOtp>((event, emit)async {
      try {
        final user = await _repository.verifyOtp(
          verificationId,
          event.otp,
        );
        if (user.user == null) {
          throw Exception("OTP is invalid");
        }
        emit(PhoneVerificationSuccess());
      } on FirebaseAuthException catch (e) {
        emit(ShowSnackBar(
            e.message ?? "Something went wrong while logging in"));
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<CheckOnboardingStatus>((event, emit) async {
      try {
        final result = await _repository.checkOnboardingStatus();
        if (result) {
          emit(NavigateToDashboard());
        } else {
          emit(NavigateToOnboarding());
        }
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }




  void _codeSent(String newVerificationId, int? resendToken) async {
    verificationId = newVerificationId;
    resendToken = resendToken;
  }

  void _autoRetrieve(String newVerificationId) async {
    verificationId = newVerificationId;
  }
}
