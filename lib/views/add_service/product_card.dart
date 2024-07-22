import 'package:attach_club/constants.dart';
import 'package:attach_club/models/product.dart';
import 'package:attach_club/views/add_service/edit_product_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                child: (product.imageUrl.isEmpty)
                    ? Container()
                    : CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => const Center(
                          child: Text(
                            "Image not found",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SizedBox(
                          width: 24,
                          height: 24,
                          child: Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                                baseColor:  Colors.grey[800]!,
                                highlightColor: Colors.grey[600]!,
                        
                              child: Container(
                                color: Colors.white,
                              ),
                            )
                        ),
                        // Image.network(
                        //   product.imageUrl,
                        //   fit: BoxFit.fill,
                        //   errorBuilder: (context, exception, stackTrace) {
                        //     return const Center(
                        //       child: Text(
                        //         "Image not found",
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   loadingBuilder: (context, child, loadingProgress) {
                        //     if (loadingProgress == null) {
                        //       return child;
                        //     } else {
                        //       return const Center(
                        //         child: SizedBox(
                        //           width: 24,
                        //           height: 24,
                        //           child: CircularProgressIndicator(
                        //             color: Colors.purple,
                        //           ),
                        //         ),
                        //       );
                        //     }
                        //   },
                        // )
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
                color: primaryTextColor,
              ),
            ),
            Text(
              "Rs ${product.price}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: primaryTextColor,
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
                color: primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
