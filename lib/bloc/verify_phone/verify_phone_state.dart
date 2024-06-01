part of 'verify_phone_bloc.dart';

sealed class VerifyPhoneState extends Equatable {
  const VerifyPhoneState();
}

final class VerifyPhoneInitial extends VerifyPhoneState {
  @override
  List<Object> get props => [];
}

class ShowSnackBar extends VerifyPhoneState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];

}

class PhoneVerificationSuccess extends VerifyPhoneState {
  @override
  List<Object?> get props => [];
}

class NavigateToOnboarding extends VerifyPhoneState {
  @override
  List<Object?> get props => [];
}

class NavigateToDashboard extends VerifyPhoneState {
  @override
  List<Object?> get props => [];
}
