part of 'complete_profile_bloc.dart';

abstract class CompleteProfileState extends Equatable {
  const CompleteProfileState();
}

class CompleteProfileInitial extends CompleteProfileState {
  @override
  List<Object> get props => [];
}

class ShowLoading extends CompleteProfileState{
  @override
  List<Object?> get props => [];
}

class ShowVerifiedIcon extends CompleteProfileState{
  @override
  List<Object?> get props => [];

}

class ButtonStatusUpdated extends CompleteProfileState{
  final bool disabled;

  const ButtonStatusUpdated(this.disabled);

  @override
  List<Object?> get props => [disabled];

}
