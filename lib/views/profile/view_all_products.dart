import 'dart:math';

import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/views/profile/product_card_with_enquiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_data.dart';

class ViewAllProducts extends StatelessWidget {
  final String phoneNo;
  const ViewAllProducts({super.key, required this.phoneNo});

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
          itemCount: _getLength(bloc.userData, bloc.productList.length),
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ProductCardWithEnquiry(
                phoneNo: phoneNo ,
                product: bloc.productList[i],
                expanded: true,
              ),
            );
          },
        ),
      ),
    );
  }
  int _getLength(UserData userData, int length) {
    if (userData.accountType=="normal") {
      return min(3, length);
    } else {
      return length;
    }
  }
}
