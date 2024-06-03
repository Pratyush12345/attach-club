import 'dart:developer';

import 'package:attach_club/bloc/home/home_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;
  HomeBloc(this._repository) : super(HomeInitial()) {
    on<GetUserData>((event, emit) async {
      final userData = await _repository.getUserData();
      emit(UserDataUpdated(userData));
    });
    on<CheckActiveStatus>((event, emit) async {
      final isActive = await _repository.checkActiveStatus();
      if(!isActive){
        emit(UserBlockedStatus());
      }
    });
  }
}
