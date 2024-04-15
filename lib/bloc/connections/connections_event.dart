part of 'connections_bloc.dart';

abstract class ConnectionsEvent extends Equatable {
  const ConnectionsEvent();
}

class FetchConnections extends ConnectionsEvent {
  @override
  List<Object?> get props => [];
}

class RequestAccepted extends ConnectionsEvent {
  final int request;

  const RequestAccepted(this.request);

  @override
  List<Object?> get props => [request];

}

class RequestRejected extends ConnectionsEvent {
  final ConnectionRequest request;

  const RequestRejected(this.request);

  @override
  List<Object?> get props => [request];

}

class RequestRemoved extends ConnectionsEvent {
  final ConnectionRequest request;

  const RequestRemoved(this.request);

  @override
  List<Object?> get props => [request];

}
