import 'dart:io';
import 'package:attach_club/bloc/dashboard/dashboard_repository.dart';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int connectionsCount = 0;
  int reviewCount = 0;
  List<UserData> suggestedProfile = [];

  final DashboardRepository _repository;

  DashboardBloc(this._repository) : super(DashboardInitial()) {
    on<GetData>((event, emit) async {
      emit(DashboardLoading());
      connectionsCount = await _repository.getConnectionsCount();
      reviewCount = await _repository.getReviewCount();
      suggestedProfile = await _repository.getSuggestedProfile(event.userData);
      emit(DataUpdated());
      emit(DashboardInitial());
    });
    on<SendWhatsappMessage>((event, emit) async {
      try {
        _repository.sendWhatsappMessage(event.phoneNo);
      } on Exception catch (e) {
        emit(const ShowSnackBar("Error launching whatsapp"));
        emit(DashboardInitial());
      }
    });
  }
}
