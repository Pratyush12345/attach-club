import 'dart:async';
import 'package:attach_club/bloc/splash_screen/splash_screen_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        await Future.delayed(const Duration(milliseconds: 500));
        if (_repository.isUserLoggedIn()) {
          final result = await _coreRepository.checkOnboardingStatus();
          await _coreRepository.uploadFcmToken();

          if(result){
            return emit(NavigateToDashboard());
          }
          return emit(NavigateToOnboarding());
        }
        return emit(NavigateToSignup());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }
}
