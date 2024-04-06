import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/components/custom_modal_sheet.dart';
import 'package:attach_club/features/on_board4/bloc/on_board4_bloc.dart';
import 'package:attach_club/features/on_board4/data/models/product.dart';
import 'package:attach_club/features/on_board4/presentation/screens/add_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showEditProductModal(
  BuildContext context,
  Product product,
) {
  showCustomModalBottomSheet(
    context: context,
    sheetHeight: 0.21,
    child: EditProductModal(
      product: product,
    ),
  );
}

class EditProductModal extends StatelessWidget {
  final Product product;

  const EditProductModal({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddProducts(
                    oldProduct: product,
                  ),
                ),
              );
            },
            title: "Edit",
            buttonWidth: 0.425581,
          ),
          const SizedBox(
            width: 16,
          ),
          CustomButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<OnBoard4Bloc>().add(DeleteProduct(product));
            },
            title: "Delete",
            buttonWidth: 0.425581,
            isDark: true,
          ),
        ],
      ),
    );
  }
}
