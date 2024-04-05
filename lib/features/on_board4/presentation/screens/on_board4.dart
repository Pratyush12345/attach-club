import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/core/constants.dart';
import 'package:attach_club/features/on_board4/bloc/on_board4_bloc.dart';
import 'package:attach_club/features/on_board4/data/models/product.dart';
import 'package:attach_club/features/on_board4/presentation/screens/add_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoard4 extends StatefulWidget {
  const OnBoard4({super.key});

  @override
  State<OnBoard4> createState() => _OnBoard4State();
}

class _OnBoard4State extends State<OnBoard4> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  bool enquiry = false;
  final List<Product> list = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OnBoard4Bloc, OnBoard4State>(
          listener: (context, state) {
            if (state is AddToList) {
              list.add(state.product);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: onBoardingHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const OnBoardingHero(
                          totalBars: 4,
                          selectedBars: 4,
                          showSkipButton: true,
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
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 0.4279 * width,
                                  height: 0.2982 * height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF181B2F),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 0.4279 * width,
                                          height: 0.4279 * width,
                                          child: Image.file(
                                            list[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        list[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Rs ${list[index].price}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        list[index].description,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: list.length,
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
                              builder: (context) => const AddProducts(),
                            ),
                          );
                        },
                        title: "Add Product",
                        isDark: true,
                      ),
                      SizedBox(
                        height: 0.016 * height,
                      ),
                      CustomButton(
                        onPressed: () {},
                        title: (list.isEmpty)?"Next":"Completed",
                        assetName: (list.isEmpty)?"assets/svg/arrow_right.svg":null,
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
}
