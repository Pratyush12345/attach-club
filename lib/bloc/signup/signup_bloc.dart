import 'dart:developer';
import 'package:attach_club/bloc/signup/signup_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository _repository;
  final CoreRepository _coreRepository;
  bool isContinuePressed = false;
  String verificationId = "";
  int? resendToken;

  SignupBloc(
    this._repository,
    this._coreRepository,
  ) : super(SignupInitial()) {
    on<GoogleLoginTriggered>((event, emit) async {
      try {
        final check = await _repository.signInWithGoogle();
        emit(GoogleLoginSuccess());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
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
    on<VerifyOtp>((event, emit) async {
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
        emit(ShowBottomSheetSnackBar(
            e.message ?? "Something went wrong while logging in"));
      } on Exception catch (e) {
        emit(ShowBottomSheetSnackBar(e.toString()));
      }
    });
    on<CheckOnboardingStatus>((event, emit) async {
      await _checkOnboardingStatus(emit);
    });
    on<CheckPhoneNumberValidity>((event, emit) async {
      final userData = await _coreRepository.getUserData();
      if(userData.phoneNo.isEmpty){
        emit(NavigateToPhoneVerification());
      }else{
        await _checkOnboardingStatus(emit);
      }
    });
  }

  Future<void> _checkOnboardingStatus(Emitter<SignupState> emit) async {
    try {
      final result = await _coreRepository.checkOnboardingStatus();
      log("result---------->>>>>>$result");
      log("onboarding status ${emit.isDone}");
      if (result) {
        emit(NavigateToDashboard());
      } else {
        emit(NavigateToOnboarding());
      }
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  void _codeSent(String newVerificationId, int? resendToken) async {
    verificationId = newVerificationId;
    resendToken = resendToken;
  }

  void _autoRetrieve(String newVerificationId) async {
    verificationId = newVerificationId;
  }
}
