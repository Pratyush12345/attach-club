part of 'buy_plan_bloc.dart';

sealed class BuyPlanEvent extends Equatable {
  const BuyPlanEvent();
}

class GetPlans extends BuyPlanEvent {
  const GetPlans();

  @override
  List<Object> get props => [];
}

class TriggerPG extends BuyPlanEvent {
  final String planCode;

  const TriggerPG(this.planCode);

  @override
  List<Object?> get props => [planCode];
}

class VerifyPayment extends BuyPlanEvent {
  final String orderId;

  const VerifyPayment(this.orderId);

  @override
  List<Object?> get props => [orderId];
}