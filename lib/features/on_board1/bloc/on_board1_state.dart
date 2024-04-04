part of 'on_board1_bloc.dart';

abstract class OnBoard1State extends Equatable {
  const OnBoard1State();
}

class OnBoard1Initial extends OnBoard1State {
  @override
  List<Object> get props => [];
}

class ShowLoading extends OnBoard1State{
  @override
  List<Object?> get props => [];
}

class ShowVerifiedIcon extends OnBoard1State{
  @override
  List<Object?> get props => [];

}

class ButtonStatusUpdated extends OnBoard1State{
  final bool disabled;

  const ButtonStatusUpdated(this.disabled);

  @override
  List<Object?> get props => [disabled];

}
