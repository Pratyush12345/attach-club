import 'dart:io';

import 'package:attach_club/bloc/add_service/add_service_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/heading.dart';
import 'package:attach_club/core/components/label.dart';
import 'package:attach_club/core/components/onboarding_hero.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/button.dart';
import 'add_images.dart';

class AddProducts extends StatefulWidget {
  final Product? oldProduct;
  final bool isOnboarding;

  const AddProducts({
    super.key,
    this.oldProduct,
    this.isOnboarding = true,
  });

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  bool enquiry = false;
  bool isProductDisabled = false;
  XFile? file;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    disabled = _isDisabled();
    if (widget.oldProduct != null) {
      titleController.text = widget.oldProduct?.title ?? "";
      descriptionController.text = widget.oldProduct?.description ?? "";
      priceController.text = widget.oldProduct?.price ?? "";
      enquiry = widget.oldProduct?.isShowEnquiryBtn ?? false;
      if (widget.oldProduct != null) {
        isProductDisabled = !widget.oldProduct!.isEnabled;
      }
      file = XFile(widget.oldProduct!.image!.path);
      disabled = _isDisabled();
    }
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
      appBar: (!widget.isOnboarding)? AppBar(
        title: Text(
          "${(widget.oldProduct == null) ? "Add" : "Edit"} "
          "Product/Service",
        ),
        centerTitle: false,
      ):null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isOnboarding)
                      ...[
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
                        Heading(
                          title:
                          "${(widget.oldProduct == null) ? "Add" : "Edit"} "
                              "Product/Service",
                        ),

                      ],
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
                      hintText: "Price",
                      keyboardType: TextInputType.number,
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
                            color: primaryTextColor,
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
                    ),
                    SizedBox(height: 0.0048 * height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Disable",
                          style: TextStyle(
                            color: primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Switch(
                          value: isProductDisabled,
                          onChanged: (value) {
                            setState(() {
                              isProductDisabled = value;
                              disabled = _isDisabled();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 0.0068 * height),
                    RichText(
                      text: TextSpan(
                          text:
                              "Turning this option on will hide this link from your profile for all users",
                          style: TextStyle(color: paragraphTextColor)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.0148 * height,
                ),
                CustomButton(
                  onPressed: () {
                    _onPress(context);
                  },
                  title: (widget.oldProduct != null) ? "Save" : "Add",
                  prefixIcon: (widget.oldProduct == null)
                      ? const Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                      : null,
                  disabled: disabled,
                ),
              ],
            ),
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

  void _onPress(BuildContext context) {
    final product = Product(
      title: titleController.text,
      description: descriptionController.text,
      price: priceController.text,
      isShowEnquiryBtn: enquiry,
      image: File(file!.path),
      dateAdded: Timestamp.now(),
      imageUrl: "",
      isEnabled: !isProductDisabled,
    );
    if (widget.oldProduct != null) {
      context.read<AddServiceBloc>().add(
            EditProduct(
              oldProduct: widget.oldProduct!,
              newProduct: product,
            ),
          );
    } else {
      context.read<AddServiceBloc>().add(
            ProductAdded(product),
          );
    }
    Navigator.pop(context);
  }
}
