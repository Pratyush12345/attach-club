import 'package:attach_club/bloc/edit_profile/edit_profile_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileRepository _repository;
  String username = "";
  String name = "";
  String profession = "";
  String description = "";
  String phoneNumber = "";
  String stateText = "";
  String pinCode = "";
  String country = "";
  String city = "";
  String businessName = "";
  List<String> professionsList = [];
  List<String> filteredProfessionsList = [];

  EditProfileBloc(this._repository) : super(EditProfileInitial()) {
    // on<OnVerifyClicked>(_onVerifyClicked);
    // on<OnFieldsUpdated>((event, emit) async {
    //   final newStatus = (event.username.isEmpty ||
    //       event.name.isEmpty ||
    //       event.profession.isEmpty ||
    //       event.about.isEmpty ||
    //       event.loading != 1);
    //   emit(ButtonStatusUpdated(newStatus));
    //   if (event.isUsernameUpdated) {
    //     emit(StopLoading());
    //   }
    //   emit(EditProfileInitial());
    // });
    // on<NextButtonClicked>(_onNextButtonClicked);
    on<GetUserData>((event, emit) async {
      try {
        final userData = await _repository.getUserData();
        username = userData.username;
        name = userData.name;
        profession = userData.profession;
        description = userData.description;
        emit(InitialUserData(userData));
      } on Exception catch (e) {
        //user data not found
        emit(ShowSnackBar("Something went wrong $e"));
      }
    });
    on<NameUpdated>(_onNameUpdated);
    on<ProfessionUpdated>(_onProfessionUpdated);
    on<DescriptionUpdated>(_onDescriptionUpdated);
    on<UpdateTriggered>(_onUserDataUpdated);
    on<GetProfessions>(_onGetProfessions);
    on<FilterProfessions>(_onFilterProfessions);
  }

  _onFilterProfessions(
    FilterProfessions event,
    Emitter<EditProfileState> emit,
  ) {
    filteredProfessionsList = professionsList
        .where((element) => element.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(const ProfessionsFiltered());
    emit(EditProfileInitial());
  }

  _onGetProfessions(
    GetProfessions event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      emit(ProfessionsLoading());
      professionsList = await _repository.getProfessions();
      filteredProfessionsList = professionsList;
      emit(const ProfessionsFiltered());
      emit(EditProfileInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
    }
  }

  _onUserDataUpdated(
    UpdateTriggered event,
    Emitter<EditProfileState> emit,
  ) async {
    await _repository.updateNamedParam(event.key, event.value);
    final userData = await _repository.getUserData();
    emit(DataUpdated(userData));
    emit(EditProfileInitial());
  }

  _onNameUpdated(
    NameUpdated event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      name = event.name;
      await _repository.updateName(name);
      final userData = await _repository.getUserData();
      emit(DataUpdated(userData));
      emit(EditProfileInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
    }
  }

  _onProfessionUpdated(
    ProfessionUpdated event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      profession = event.profession;
      await _repository.updateProfession(profession);
      final userData = await _repository.getUserData();
      emit(DataUpdated(userData));
      emit(EditProfileInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
    }
  }

  _onDescriptionUpdated(
    DescriptionUpdated event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      description = event.description;
      await _repository.updateDescription(description);
      final userData = await _repository.getUserData();
      emit(DataUpdated(userData));
      emit(EditProfileInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar("Something went wrong $e"));
    }
  }

// _onVerifyClicked(
//     OnVerifyClicked event,
//     Emitter<EditProfileState> emit,
//     ) async {
//   try {
//     if (event.username.isNotEmpty) {
//       emit(ShowLoading());
//       emit(EditProfileInitial());
//       final result = await _repository.isUsernameAvailable(event.username);
//       if (result) {
//         emit(ShowVerifiedIcon());
//         emit(EditProfileInitial());
//       } else {
//         emit(const ShowSnackBar("Username not available"));
//         emit(StopLoading());
//         emit(EditProfileInitial());
//       }
//     } else {
//       emit(const ShowSnackBar("Enter username first."));
//       emit(EditProfileInitial());
//     }
//   } on Exception catch (e) {
//     emit(ShowSnackBar("Something went wrong $e"));
//     emit(EditProfileInitial());
//   }
// }

// _onNextButtonClicked(
//     NextButtonClicked event,
//     Emitter<EditProfileState> emit,
//     ) async {
//   try {
//     if (event.username.isEmpty) {
//       throw ("Please enter username");
//     }
//     if (event.name.isEmpty) {
//       throw ("Please enter name");
//     }
//     if (event.profession.isEmpty) {
//       throw ("Please enter profession");
//     }
//     if (event.description.isEmpty) {
//       throw ("Please enter description");
//     }
//     if(!event.isVerified){
//       throw ("Please verify username");
//     }
//
//     final user = UserData(
//       username: event.username,
//       name: event.name,
//       profession: event.profession,
//       description: event.description,
//     );
//     await _repository.uploadUserData(user);
//     await _repository.uploadUserToRealtime(user);
//     emit(NavigateToNextPage());
//   } on String catch (e) {
//     emit(ShowSnackBar(e));
//   } on Exception catch (e) {
//     emit(ShowSnackBar("Something went wrong $e"));
//   }
// }
}
