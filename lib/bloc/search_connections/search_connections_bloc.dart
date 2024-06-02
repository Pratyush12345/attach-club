import 'dart:developer';

import 'package:attach_club/bloc/search_connections/search_connections_repository.dart';
import 'package:attach_club/models/search_user_data.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_connections_event.dart';
part 'search_connections_state.dart';
 
class SearchConnectionsBloc extends Bloc<SearchConnectionsEvent, SearchConnectionsState> {
  final SearchConnectionsRepository _repository;
  List<SearchUserData> resultsList = [];
  // Set<String> requestsLoading = {};
  Set<String> requestsSent = {};
  SearchConnectionsBloc(this._repository) : super(SearchConnectionsInitial()) {
    on<SearchTriggered>((event, emit) async {
      try {
        emit(SearchConnectionsLoading());
        resultsList = await _repository.getSearchResult(event.query);
        emit(SearchConnectionsLoaded());
      } on Exception catch (e) {
        log(e.toString());
        emit(ShowSnackBar(e.toString()));
        emit(SearchConnectionsInitial());
      }
    });
    on<ConnectButtonClicked>((event, emit) async {
      try {
        // requestsLoading.add(event.userUid);
        //emit(ConnectionRequestLoading());
        await _repository.sendConnectionRequest(event.userUid);
        // requestsLoading.remove(event.userUid);
        requestsSent.add(event.userUid);
        //emit(ConnectionRequestSent());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }
}
