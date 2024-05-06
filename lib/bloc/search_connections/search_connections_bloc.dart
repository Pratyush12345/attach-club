import 'package:attach_club/bloc/search_connections/search_connections_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_connections_event.dart';
part 'search_connections_state.dart';

class SearchConnectionsBloc extends Bloc<SearchConnectionsEvent, SearchConnectionsState> {
  final SearchConnectionsRepository _repository;
  List<UserData> resultsList = [];
  SearchConnectionsBloc(this._repository) : super(SearchConnectionsInitial()) {
    on<SearchTriggered>((event, emit) async {
      try {
        emit(SearchConnectionsLoading());
        resultsList = await _repository.getSearchResult(event.query);
        emit(SearchConnectionsLoaded());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }
}
