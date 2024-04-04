part of 'on_board1_bloc.dart';

abstract class OnBoard1Event extends Equatable {
  const OnBoard1Event();
}

class OnVerifyClicked extends OnBoard1Event {
  final String username;

  const OnVerifyClicked(this.username);

  @override
  List<Object?> get props => [];
}

class OnFieldsUpdated extends OnBoard1Event {
  final String username;
  final String name;
  final String profession;
  final String about;
  final int loading;

  OnFieldsUpdated({
    required this.username,
    required this.name,
    required this.profession,
    required this.about,
    required this.loading,
  });

  @override
  List<Object?> get props => [username, name, profession, about];
}
