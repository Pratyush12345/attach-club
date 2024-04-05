import 'dart:io';

import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_add_icon.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/core/constants.dart';
import 'package:attach_club/features/on_board4/bloc/on_board4_bloc.dart';
import 'package:attach_club/features/on_board4/data/models/product.dart';
import 'package:attach_club/features/on_board4/presentation/widgets/add_images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  bool enquiry = false;
  XFile? file;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    disabled = _isDisabled();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: onBoardingHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OnBoardingHero(
                    totalBars: 4,
                    selectedBars: 4,
                    showBackButton: true,
                    onBack: () {
                      Navigator.of(context).pop();
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
                    title: "Enter your product or service details here",
                  ),
                  SizedBox(
                    height: 0.0257 * height,
                  ),
                  CustomTextField(
                    type: TextFieldType.RegularTextField,
                    controller: titleController,
                    hintText: "Product Title",
                    onChanged: (s) {
                      setState(() {
                        disabled = _isDisabled();
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.0128 * height,
                  ),
                  AddImages(
                    file: file,
                    callback: (selectedFile) {
                      setState(() {
                        file = selectedFile;
                        disabled = _isDisabled();
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.0128 * height,
                  ),
                  CustomTextField(
                    type: TextFieldType.RegularTextField,
                    controller: descriptionController,
                    hintText: "Product Description",
                    onChanged: (s) {
                      setState(() {
                        disabled = _isDisabled();
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.0128 * height,
                  ),
                  CustomTextField(
                    type: TextFieldType.RegularTextField,
                    controller: priceController,
                    hintText: "Price (optional)",
                    onChanged: (s) {
                      setState(() {
                        disabled = _isDisabled();
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.0128 * height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Show enquiry button",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: enquiry,
                        onChanged: (value) {
                          setState(() {
                            enquiry = value;
                            disabled = _isDisabled();
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              CustomButton(
                onPressed: () {
                  context.read<OnBoard4Bloc>().add(
                        ProductAdded(Product(
                          title: titleController.text,
                          description: descriptionController.text,
                          price: priceController.text,
                          showEnquiry: enquiry,
                          image: File(file!.path),
                        )),
                      );
                  Navigator.pop(context);
                },
                title: "Add",
                prefixIcon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                disabled: disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isDisabled() {
    return (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        file == null);
  }
}
