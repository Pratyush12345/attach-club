import 'dart:async';
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

  SignupBloc(
    this._repository,
    this._coreRepository,
  ) : super(SignupInitial()) {
    on<GoogleLoginTriggered>((event, emit) async {
      try {
        await _repository.signInWithGoogle();
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
          codeSent: event.codeSent,
          verificationCompleted: event.verificationCompleted,
        );
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<VerifyOtp>((event, emit) async {
      try {
        await Future.delayed(const Duration(seconds: 2));
        final user = await _repository.verifyOtp(
          event.verificationId,
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
      try {
        final result = await _coreRepository.checkOnboardingStatus();
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
}
