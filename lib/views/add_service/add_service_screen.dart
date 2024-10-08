import 'dart:developer';

import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/views/add_service/add_products.dart';
import 'package:attach_club/views/add_service/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/button.dart';
import '../../core/components/heading.dart';
import '../../core/components/label.dart';
import '../../core/components/onboarding_hero.dart';

class AddService extends StatefulWidget {
  final bool isInsideManageProfile;

  const AddService({
    super.key,
    this.isInsideManageProfile = false,
  });

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  bool enquiry = false;

  _onPress(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName("/home"));
    Navigator.of(context).pushNamed("/home");
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AddServiceBloc>();
    if (bloc.lastUpdated == null ||
        DateTime.now().difference(bloc.lastUpdated!).inMinutes > 2) {
      bloc.add(FetchAllProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    log(widget.isInsideManageProfile.toString());
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AddServiceBloc, AddServiceState>(
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ShowLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
            final list = context.read<AddServiceBloc>().list;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._getHeader(height),
                        SizedBox(
                          height: 0.0257 * height,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 0.4279 * width,
                              mainAxisExtent: 0.2982 * height,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 19,
                            ),
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                product: list[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProducts(
                                isOnboarding: !widget.isInsideManageProfile,
                              ),
                            ),
                          );
                        },
                        title: "Add Product",
                        // isDark: true,
                      ),
                      SizedBox(
                        height: 0.016 * height,
                      ),
                      if (!widget.isInsideManageProfile)
                        CustomButton(
                          onPressed: () {
                            _onPress(context);
                          },
                          title: (list.isEmpty) ? "Next" : "Complete",
                          assetName: (list.isEmpty)
                              ? "assets/svg/arrow_right.svg"
                              : null,
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _getHeader(double height) {
    if (!widget.isInsideManageProfile) {
      return [
        OnBoardingHero(
          totalBars: 4,
          selectedBars: 4,
          showSkipButton: true,
          onSkip: () {
            _onPress(context);
          },
        ),
        SizedBox(
          height: 0.0257 * height,
        ),
        const Heading(title: "Add Product/Service"),
        SizedBox(
          height: 0.03433 * height,
        ),
        const Label(
          title: "Add your products or expertise services",
        ),
      ];
    }
    return [];
  }
}
