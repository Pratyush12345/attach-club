part of 'search_connections_bloc.dart';

abstract class SearchConnectionsEvent extends Equatable {
  const SearchConnectionsEvent();
}

class SearchTriggered extends SearchConnectionsEvent {
  final String query;

  const SearchTriggered(this.query);

  @override
  List<Object> get props => [query];
}