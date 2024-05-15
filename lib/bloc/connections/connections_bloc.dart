import 'package:attach_club/bloc/connections/connections_repository.dart';
import 'package:attach_club/constants.dart';
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
      emit(const ConnectionsLoading());
      final allList = await _repository.fetchConnections();
      final newConnectedList = <ConnectionRequest>[];
      final newSentList = <ConnectionRequest>[];
      final newReceivedList = <ConnectionRequest>[];
      for (var i in allList) {
        if (i.status == CONNECTION_CONNECTED_STATUS) {
          newConnectedList.add(i);
        }
        if (i.status == CONNECTION_RECEIVED_STATUS) {
          newReceivedList.add(i);
        }
        if (i.status == CONNECTION_SENT_STATUS) {
          newSentList.add(i);
        }
      }
      connectedList = newConnectedList;
      sentList = newSentList;
      receivedList = newReceivedList;
      emit(const ListsUpdated());
      emit(ConnectionsNeutral());
    });
    on<RequestAccepted>((event, emit) async {
      connectedList.add(receivedList[event.request]);
      await _repository.acceptRequest(receivedList[event.request]);
      receivedList.removeAt(event.request);
      emit(const ListsUpdated());
      emit(ConnectionsNeutral());
    });
    on<RequestRejected>((event, emit) async {
      receivedList.remove(event.request);
      await _repository.rejectRequest(event.request);
      emit(const ListsUpdated());
      emit(ConnectionsNeutral());
    });
    on<RequestRemoved>((event, emit) async {
      sentList.remove(event.request);
      await _repository.rejectRequest(event.request);
      emit(const ListsUpdated());
      emit(ConnectionsNeutral());
    });
    on<WhatsappIconClicked>((event, emit) async {
      try {
        await _repository.whatsappIconClicked(event.phoneNo);
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
        emit(ConnectionsNeutral());
      }
    });
    on<PhoneIconClicked>((event, emit) async {
      try {
        await _repository.phoneIconClicked(event.phoneNo);
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
        emit(ConnectionsInitial());
      }
    });
  }
}
