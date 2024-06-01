part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoading extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsUpdated extends NotificationsState {
  @override
  List<Object> get props => [];
}

class ShowSnackBar extends NotificationsState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object> get props => [message];
}
