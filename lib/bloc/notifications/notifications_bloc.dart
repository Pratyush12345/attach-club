import 'dart:developer';

import 'package:attach_club/bloc/notifications/notifications_repository.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/models/notification_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _repository;
  List<ConnectionRequest> requestList = [];
  List<NotificationData> publicAlerts = [];
  List<NotificationData> privateAlerts = [];

  NotificationsBloc(this._repository) : super(NotificationsInitial()) {
    on<GetNotifications>((event, emit)async {
      try {
        emit(NotificationsLoading());
        //sort the connectionList by creationDate newest to oldest\
        requestList = event.connectedList + event.sentList + event.receivedList;
        requestList.sort((a, b) => b.updateTime.compareTo(a.updateTime));

        publicAlerts = await _repository.getPublicAlerts();
        publicAlerts.sort((a, b) => b.creationDate.compareTo(a.creationDate));
        privateAlerts = await _repository.getPrivateAlerts();
        privateAlerts.sort((a, b) => b.creationDate.compareTo(a.creationDate));
        emit(NotificationsUpdated());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }
}
