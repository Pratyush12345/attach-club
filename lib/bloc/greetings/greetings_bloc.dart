import 'package:attach_club/bloc/greetings/greetings_repository.dart';
import 'package:attach_club/models/greeting_topic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'greetings_event.dart';

part 'greetings_state.dart';

class GreetingsBloc extends Bloc<GreetingsEvent, GreetingsState> {
  final GreetingsRepository _repository;
  List<GreetingTopic> list = [];
  List<GreetingTopic> filteredList = [];

  GreetingsBloc(this._repository) : super(GreetingsInitial()) {
    on<GetGreetings>((event, emit) async {
      try {
        emit(const GreetingsLoading());
        list = await _repository.fetchGreetings();
        filteredList = list;
        emit(const GreetingsLoaded());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<SearchTriggered>((event, emit) async {
      try {
        filteredList = list
            .where((element) => element.categoryName
                .toLowerCase()
                .contains(event.query.toLowerCase()))
            .toList();
        emit(const GreetingsLoaded());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }
}
