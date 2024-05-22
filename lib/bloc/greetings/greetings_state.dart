part of 'greetings_bloc.dart';

sealed class GreetingsState extends Equatable {
  const GreetingsState();
}

final class GreetingsInitial extends GreetingsState {
  @override
  List<Object> get props => [];
}

class GreetingsLoading extends GreetingsState {

  const GreetingsLoading();

  @override
  List<Object> get props => [];
}

class ShowSnackBar extends GreetingsState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object> get props => [message];
}

class GreetingsLoaded extends GreetingsState {

  const GreetingsLoaded();

  @override
  List<Object> get props => [];
}