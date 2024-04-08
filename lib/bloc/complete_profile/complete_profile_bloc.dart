import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileInitial()) {
    on<OnVerifyClicked>((event, emit)async {
      if(event.username.isNotEmpty){
        emit(ShowLoading());
        await Future.delayed(const Duration(seconds: 1));
        emit(ShowVerifiedIcon());
      }
    });
    on<OnFieldsUpdated>((event, emit)async {
      final newStatus = (event.username.isEmpty ||
          event.name.isEmpty ||
          event.profession.isEmpty ||
          event.about.isEmpty ||
          event.loading != 1);
      emit(ButtonStatusUpdated(newStatus));
    });
  }
}
