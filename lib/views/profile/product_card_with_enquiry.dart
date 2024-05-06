import 'package:attach_club/constants.dart';
import 'package:attach_club/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCardWithEnquiry extends StatelessWidget {
  final Product product;
  final bool expanded;

  const ProductCardWithEnquiry({
    super.key,
    required this.product,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xFF26293B),
      child: SizedBox(
        width: 0.5651162791 * width,
        height: (expanded) ? null : 0.3805150215 * height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (product.image == null)
                  ? SizedBox(
                      height: 0.1974248927 * height,
                    )
                  : Image.file(
                      product.image!,
                      height: 0.1974248927 * height,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          text: product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          text: product.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Rs. ${product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      if (expanded)
                        const SizedBox(
                          height: 14,
                        )
                    ],
                  ),
                  Visibility(
                    visible: product.isShowEnquiryBtn,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4285F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          fixedSize: Size(
                            (expanded) ? width : 0.5046511628 * width,
                            32,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Query",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
