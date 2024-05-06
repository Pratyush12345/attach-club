part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DataUpdated extends DashboardState {
  @override
  List<Object?> get props => [];
}

class ShowSnackBar extends DashboardState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}
