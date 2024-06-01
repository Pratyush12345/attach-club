part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class GetNotifications extends NotificationsEvent {
  final List<ConnectionRequest> connectedList;
  final List<ConnectionRequest> sentList;
  final List<ConnectionRequest> receivedList;

  const GetNotifications({
    required this.connectedList,
    required this.sentList,
    required this.receivedList,
  });

  @override
  List<Object> get props => [];
}
