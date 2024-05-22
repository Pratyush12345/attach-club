part of 'greetings_bloc.dart';

sealed class GreetingsEvent extends Equatable {
  const GreetingsEvent();
}

class GetGreetings extends GreetingsEvent {

  const GetGreetings();

  @override
  List<Object> get props => [];
}

class SearchTriggered extends GreetingsEvent {
  final String query;

  const SearchTriggered(this.query);

  @override
  List<Object> get props => [query];
}