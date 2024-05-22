import 'package:attach_club/bloc/buy_plan/buy_plan_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/views/buy_plan/feature_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';

import 'plan_card.dart';

class BuyPlan extends StatefulWidget {
  const BuyPlan({super.key});

  @override
  State<BuyPlan> createState() => _BuyPlanState();
}

class _BuyPlanState extends State<BuyPlan> {
  int selectedIndex = 0;
  var cfPaymentGatewayService = CFPaymentGatewayService();


  @override
  void initState() {
    super.initState();
    context.read<BuyPlanBloc>().add(const GetPlans());
    cfPaymentGatewayService.setCallback(verifyPayment, onPaymentError);
  }

  void verifyPayment(String orderId) {
    context.read<BuyPlanBloc>().add(VerifyPayment(orderId));
  }

  void onPaymentError(CFErrorResponse errorResponse, String orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text("payment failed ${errorResponse.getMessage().toString()}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Plan'),
        centerTitle: true,
        // backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: BlocConsumer<BuyPlanBloc, BuyPlanState>(
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is StartCashFreeService) {
              cfPaymentGatewayService.doPayment(state.cfDropCheckoutPayment);
            }
            if (state is UpdateUserData) {
              context.read<UserDataNotifier>().updateUserData(state.userData);
            }
            if (state is PaymentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Payment Success"),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is BuyPlanLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final list = context.read<BuyPlanBloc>().list;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 0.01502145923 * height),
                          RichText(
                            text: const TextSpan(
                              text:
                                  "Explore premium plans for enhanced features and benefits. Elevate your experience with advanced tools. Upgrade now!",
                              style: TextStyle(
                                color: Color(0xFF8B8D97),
                                fontSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 0.01502145923 * height),
                          const FeatureCard(
                            title: "Social Greetings",
                            subTitle:
                                "Access to the unlimited creatives on all occasions with your name and logo on it. ",
                          ),
                          SizedBox(height: 0.01502145923 * height),
                          const FeatureCard(
                            title: "Products Display",
                            subTitle:
                                "Showcase your products on your profile and scale your business.",
                          ),
                          SizedBox(height: 0.01502145923 * height),
                          const FeatureCard(
                            title: "Discover Unlimited Peoples",
                            subTitle:
                                "View the profiles of unlimited users across the world and make connection with them ",
                          ),
                          SizedBox(height: 0.01502145923 * height),
                          const Text(
                            "Choose a plan that suits you best",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 0.01502145923 * height),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 0.1201716738 * height,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return PlanCard(
                                planCode: list[index].planCode,
                                price: list[index].planPrice,
                                discount: list[index].discountInPer,
                                updateSelectedPlan: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                gradient: selectedIndex == index,
                              );
                            },
                          ),
                          SizedBox(height: 0.01502145923 * height),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      context.read<BuyPlanBloc>().add(
                            TriggerPG(list[selectedIndex].planCode),
                          );
                    },
                    title: "Subscribe",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
