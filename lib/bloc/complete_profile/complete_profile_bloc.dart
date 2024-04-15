import 'package:attach_club/bloc/complete_profile/complete_profile_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complete_profile_event.dart';

part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final CompleteProfileRepository _repository;

  CompleteProfileBloc(this._repository) : super(CompleteProfileInitial()) {
    on<OnVerifyClicked>(_onVerifyClicked);
    on<OnFieldsUpdated>((event, emit) async {
      final newStatus = (event.username.isEmpty ||
          event.name.isEmpty ||
          event.profession.isEmpty ||
          event.about.isEmpty ||
          event.loading != 1);
      emit(ButtonStatusUpdated(newStatus));
      if (event.isUsernameUpdated) {
        emit(StopLoading());
      }
      emit(CompleteProfileInitial());
    });
    on<NextButtonClicked>(_onNextButtonClicked);
  }

  _onVerifyClicked(
    OnVerifyClicked event,
    Emitter<CompleteProfileState> emit,
  ) async {
    try {
      if (event.username.isNotEmpty) {
        emit(ShowLoading());
        emit(CompleteProfileInitial());
        final result = await _repository.isUsernameAvailable(event.username);
        if (result) {
          emit(ShowVerifiedIcon());
          emit(CompleteProfileInitial());
        } else {
          emit(const ShowSnackBar("Username not available"));
          emit(StopLoading());
          emit(CompleteProfileInitial());
        }
      } else {
        emit(const ShowSnackBar("Enter username first."));
        emit(CompleteProfileInitial());
      }
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
      emit(CompleteProfileInitial());
    }
  }

  _onNextButtonClicked(
    NextButtonClicked event,
    Emitter<CompleteProfileState> emit,
  ) async {
    try {
      if (event.username.isEmpty) {
        throw Exception("Username empty");
      }
      if (event.name.isEmpty) {
        throw Exception("Name empty");
      }
      if (event.profession.isEmpty) {
        throw Exception("Profession empty");
      }
      if (event.description.isEmpty) {
        throw Exception("Description empty");
      }

      final user = UserData(
        username: event.username,
        name: event.name,
        profession: event.profession,
        description: event.description,
      );
      await _repository.uploadUserData(user);
      emit(NavigateToNextPage());
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }
}
