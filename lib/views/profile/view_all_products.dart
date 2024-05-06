import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/views/profile/product_card_with_enquiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllProducts extends StatelessWidget {
  const ViewAllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: ListView.builder(
          itemCount: bloc.productList.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ProductCardWithEnquiry(
                product: bloc.productList[i],
                expanded: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
