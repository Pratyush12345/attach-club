import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'on_board1_event.dart';
part 'on_board1_state.dart';

class OnBoard1Bloc extends Bloc<OnBoard1Event, OnBoard1State> {
  OnBoard1Bloc() : super(OnBoard1Initial()) {
    on<OnVerifyClicked>((event, emit)async {
      log("messageeeeeeee");
      if(event.username.isNotEmpty){
        log("showing loading icon");
        emit(ShowLoading());
        await Future.delayed(const Duration(seconds: 1));
        log("Showing icon");
        emit(ShowVerifiedIcon());
      }else{
        log("Showing nothing");
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
