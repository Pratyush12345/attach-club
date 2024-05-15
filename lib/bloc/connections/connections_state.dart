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
