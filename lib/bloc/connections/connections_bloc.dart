import 'package:attach_club/bloc/connections/connections_repository.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connections_event.dart';

part 'connections_state.dart';

class ConnectionsBloc extends Bloc<ConnectionsEvent, ConnectionsState> {
  final ConnectionsRepository _repository;
  List<ConnectionRequest> connectedList = <ConnectionRequest>[];
  List<ConnectionRequest> sentList = <ConnectionRequest>[];
  List<ConnectionRequest> receivedList = <ConnectionRequest>[];

  ConnectionsBloc(this._repository) : super(ConnectionsInitial()) {
    on<FetchConnections>((event, emit) async {
      final allList = await _repository.fetchConnections();
      final newConnectedList = <ConnectionRequest>[];
      final newSentList = <ConnectionRequest>[];
      final newReceivedList = <ConnectionRequest>[];
      for (var i in allList) {
        if (i.status == "Connected") {
          newConnectedList.add(i);
        }
        if (i.status == "Received") {
          newReceivedList.add(i);
        }
        if (i.status == "Sent") {
          newSentList.add(i);
        }
      }
      connectedList = newConnectedList;
      sentList = newSentList;
      receivedList = newReceivedList;
      emit(const ListsUpdated());
      emit(ConnectionsInitial());
    });
    on<RequestAccepted>((event, emit) async {
      connectedList.add(receivedList[event.request]);
      await _repository.acceptRequest(receivedList[event.request]);
      receivedList.removeAt(event.request);
      emit(const ListsUpdated());
      emit(ConnectionsInitial());
    });
    on<RequestRejected>((event, emit) async {
      receivedList.remove(event.request);
      await _repository.rejectRequest(event.request);
      emit(const ListsUpdated());
      emit(ConnectionsInitial());
    });
    on<RequestRemoved>((event, emit) async {
      sentList.remove(event.request);
      await _repository.rejectRequest(event.request);
      emit(const ListsUpdated());
      emit(ConnectionsInitial());
    });
  }
}
