import 'package:attach_club/features/on_board4/data/models/product.dart';
import 'package:attach_club/features/on_board4/presentation/screens/edit_product_modal.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showEditProductModal(context, product);
      },
      child: Container(
        width: 0.4279 * width,
        height: 0.2982 * height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF181B2F),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 0.4279 * width,
                height: 0.4279 * width,
                child: Image.file(
                  product.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              "Rs ${product.price}",
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
              product.description,
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
  }
}
