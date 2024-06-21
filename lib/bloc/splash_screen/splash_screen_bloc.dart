import 'dart:async';
import 'dart:developer';
import 'package:attach_club/bloc/splash_screen/splash_screen_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final SplashScreenRepository _repository;
  final CoreRepository _coreRepository;

  SplashScreenBloc(
    this._repository,
    this._coreRepository,
  ) : super(SplashScreenInitial()) {
    on<CheckLoginStatus>((event, emit) async {
      try {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setInt('counter', 0);
        // await prefs.setString('counterDate', DateTime.now().toString());
        await Future.delayed(const Duration(milliseconds: 500));
        if (_repository.isUserLoggedIn()) {
          final userData = await _coreRepository.getUserData();
          if (FirebaseAuth.instance.currentUser!.phoneNumber != null) {
            if (userData.phoneNo.isEmpty) {
              await _coreRepository.updatePhoneNo(
                FirebaseAuth.instance.currentUser!.phoneNumber!,
              );
            }
          } else {
            return emit(NavigateToVerifyPhone());
          }
          final result = await _coreRepository.checkOnboardingStatus();
          await _coreRepository.uploadFcmToken();

          if (result) {
            return emit(NavigateToDashboard());
          }
          return emit(NavigateToOnboarding());
        }
        if (event.isInsideIntro) {
          return emit(NavigateToSignup());
        }
        return emit(NavigateToIntro());
      } on Exception catch (e) {
        log(e.toString());
        if (e.toString() == "Exception: User data not found") {
          if (event.isInsideIntro) {
            return emit(NavigateToSignup());
          }
          return emit(NavigateToIntro());
        } else {
          emit(ShowSnackBar(e.toString()));
        }
      }
    });
  }
}
