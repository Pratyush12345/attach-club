part of 'buy_plan_bloc.dart';

sealed class BuyPlanState extends Equatable {
  const BuyPlanState();
}

final class BuyPlanInitial extends BuyPlanState {
  @override
  List<Object> get props => [];
}

class BuyPlanLoading extends BuyPlanState {
  @override
  List<Object> get props => [];
}

class ShowSnackBar extends BuyPlanState {
  final String message;
  ShowSnackBar(this.message);

  @override
  List<Object> get props => [message];
}

class BuyPlanLoaded extends BuyPlanState {

  const BuyPlanLoaded();

  @override
  List<Object> get props => [];
}

class StartCashFreeService extends BuyPlanState {
  final CFDropCheckoutPayment cfDropCheckoutPayment;

  const StartCashFreeService(this.cfDropCheckoutPayment);

  @override
  List<Object?> get props => [cfDropCheckoutPayment];
}

class UpdateUserData extends BuyPlanState {
  final UserData userData;

  const UpdateUserData(this.userData);

  @override
  List<Object?> get props => [userData];
}

class PaymentSuccess extends BuyPlanState {
  const PaymentSuccess();

  @override
  List<Object> get props => [];
}