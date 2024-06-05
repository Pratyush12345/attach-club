import 'dart:developer';

import 'package:attach_club/bloc/complete_profile/complete_profile_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complete_profile_event.dart';

part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final CompleteProfileRepository _repository;

  CompleteProfileBloc(this._repository) : super(CompleteProfileInitial()) {
    on<OnVerifyClicked>(_onVerifyClicked);
    on<OnFieldsUpdated>((event, emit) async {
      final newStatus = (event.username.isEmpty ||
          event.name.isEmpty ||
          event.profession.isEmpty ||
          event.about.isEmpty ||
          event.state.isEmpty ||
          event.city.isEmpty ||
          event.country.isEmpty ||
          event.pincode.isEmpty ||
          event.phoneNo.isEmpty ||
          event.loading != 1);
      emit(ButtonStatusUpdated(newStatus));
      if (event.isUsernameUpdated) {
        emit(StopLoading());
      }
      emit(CompleteProfileInitial());
    });
    on<NextButtonClicked>(_onNextButtonClicked);
    on<GetUserData>((event, emit) async {
      try {
        emit(InitialUserData(await _repository.getUserData()));
        emit(CompleteProfileInitial());
      } on Exception catch (e) {
        //user data not found
        log(e.toString());
      }
    });
  }

  _onVerifyClicked(
    OnVerifyClicked event,
    Emitter<CompleteProfileState> emit,
  ) async {
    try {
      if (event.username.isNotEmpty) {
        emit(ShowLoading());
        emit(CompleteProfileInitial());
        final result = await _repository.isUsernameAvailable(event.username);
        if (result) {
          emit(ShowVerifiedIcon());
          emit(CompleteProfileInitial());
        } else {
          emit(const ShowSnackBar("Username not available"));
          emit(StopLoading());
          emit(CompleteProfileInitial());
        }
      } else {
        emit(const ShowSnackBar("Enter username first."));
        emit(CompleteProfileInitial());
      }
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
      emit(CompleteProfileInitial());
    }
  }

  _onNextButtonClicked(
    NextButtonClicked event,
    Emitter<CompleteProfileState> emit,
  ) async {
    try {
      if (event.username.isEmpty) {
        throw ("Please enter username");
      }
      if (event.name.isEmpty) {
        throw ("Please enter name");
      }
      if (event.profession.isEmpty) {
        throw ("Please enter profession");
      }
      if (event.description.isEmpty) {
        throw ("Please enter description");
      }
      if (event.state.isEmpty) {
        throw ("Please enter state");
      }
      if (event.city.isEmpty) {
        throw ("Please enter city");
      }
      if (event.pincode.isEmpty) {
        throw ("Please enter pincode");
      }
      if (event.phoneNo.isEmpty) {
        throw ("Please enter phone number");
      }
      if (!event.isVerified) {
        throw ("Please verify username");
      }

      final user = UserData(
        accountType: "premium",
        username: event.username,
        name: event.name,
        profession: event.profession,
        description: event.description,
        state: event.state,
        city: event.city,
        pin: event.pincode,
        country: event.country,
        phoneNo: (event.phoneNo[0] == "+")
            ? event.phoneNo.substring(3)
            : event.phoneNo,
        firstLoginDate: Timestamp.now(),
        lastLoginDate: Timestamp.now(),
        lastPaymentDate: Timestamp.now(),
        isPlanExpiredRecently: false,
        planExitDate: Timestamp.fromDate(DateTime.now().add(const Duration(days: 60))),
        planPurchaseDate: Timestamp.now(),
        purchasedPlanCode: "60DP",
      );
      await _repository.uploadUserData(user);
      await _repository.uploadUserToRealtime(user);
      emit(NavigateToNextPage());
      emit(CompleteProfileInitial());
    } on String catch (e) {
      emit(ShowSnackBar(e));
      emit(CompleteProfileInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
      emit(CompleteProfileInitial());
    }
  }
}
