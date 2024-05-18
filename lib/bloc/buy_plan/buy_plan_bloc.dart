import 'dart:convert';

import 'package:attach_club/bloc/buy_plan/buy_plan_repository.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/plan.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';

part 'buy_plan_event.dart';
part 'buy_plan_state.dart';

class BuyPlanBloc extends Bloc<BuyPlanEvent, BuyPlanState> {
  final BuyPlanRepository _repository;
  List<Plan> list = [];
  BuyPlanBloc(this._repository) : super(BuyPlanInitial()) {
    on<GetPlans>((event, emit) async {
      // try {
        emit(BuyPlanLoading());
        list = await _repository.buyPlan();
        emit(const BuyPlanLoaded());
      // } catch (e) {
      //   emit(ShowSnackBar(e.toString()));
      // }
    });
    on<TriggerPG>(_onTriggerPG);
    on<VerifyPayment>(_verifyPayment);
  }
  _onTriggerPG(TriggerPG event, Emitter<BuyPlanState> emit) async {
    try {
      emit(BuyPlanLoading());
      final response = await _repository.placeOrder();
      final json = jsonDecode(response);
      final orderId = json["order_id"].toString();
      final sessionId = json["payment_session_id"].toString();

      final cfSession = CFSessionBuilder()
          .setEnvironment(cfEnvironment)
          .setOrderId(orderId)
          .setPaymentSessionId(sessionId)
          .build();


      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(cfSession)
          .setTheme(theme)
          .build();

      emit(StartCashFreeService(cfDropCheckoutPayment));
      emit(BuyPlanInitial());
    } on Exception catch (e) {
      emit(ShowSnackBar("Error triggering PG $e"));
      emit(BuyPlanInitial());
    }
  }

  _verifyPayment(VerifyPayment event, Emitter<BuyPlanState> emit) async {
    emit(BuyPlanLoading());
    try {
      final response = await _repository.verifyPayment(event.orderId);
      final userData = await _repository.getUserData();
      emit(UpdateUserData(userData));
      if (response) {
        emit(const PaymentSuccess());
        emit(BuyPlanInitial());
      }else{
        emit(ShowSnackBar("Payment Failed"));
        emit(BuyPlanInitial());
      }
    } on Exception catch (e) {
      emit(ShowSnackBar("Error verifying payment $e"));
      emit(BuyPlanInitial());
    }
  }
}
