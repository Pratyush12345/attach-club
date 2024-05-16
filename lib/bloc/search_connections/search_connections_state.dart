part of 'search_connections_bloc.dart';

abstract class SearchConnectionsState extends Equatable {
  const SearchConnectionsState();
}

class SearchConnectionsInitial extends SearchConnectionsState {
  @override
  List<Object> get props => [];
}

class SearchConnectionsLoading extends SearchConnectionsState {
  @override
  List<Object> get props => [];
}

class SearchConnectionsLoaded extends SearchConnectionsState {
  // final List<UserData> searchResults;
  SearchConnectionsLoaded();

  @override
  List<Object> get props => [];
}

class ShowSnackBar extends SearchConnectionsState {
  final String message;
  const ShowSnackBar(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionRequestLoading extends SearchConnectionsState {
  @override
  List<Object> get props => [];
}

class ConnectionRequestSent extends SearchConnectionsState {
  @override
  List<Object> get props => [];
}