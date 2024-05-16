part of 'connections_bloc.dart';

abstract class ConnectionsState extends Equatable {
  const ConnectionsState();
}

class ConnectionsInitial extends ConnectionsState {
  @override
  List<Object> get props => [];
}

class ListsUpdated extends ConnectionsState {
  const ListsUpdated();

  @override
  List<Object?> get props => [];
}

class ShowSnackBar extends ConnectionsState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}

class ConnectionsLoading extends ConnectionsState {
  const ConnectionsLoading();

  @override
  List<Object?> get props => [];
}

class ConnectionsNeutral extends ConnectionsState {
  @override
  List<Object> get props => [];
}
