part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class ShowSnackBar extends SignupState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];

}

class GoogleLoginSuccess extends SignupState {
  @override
  List<Object?> get props => [];
}

class PhoneVerificationSuccess extends SignupState {
  @override
  List<Object?> get props => [];
}

class NavigateToOnboarding extends SignupState {
  @override
  List<Object?> get props => [];
}

class NavigateToDashboard extends SignupState {
  @override
  List<Object?> get props => [];
}

class ShowBottomSheetSnackBar extends SignupState {
  final String message;

  const ShowBottomSheetSnackBar(this.message);

  @override
  List<Object?> get props => [message];

}

class NavigateToPhoneVerification extends SignupState {
  @override
  List<Object?> get props => [];
}