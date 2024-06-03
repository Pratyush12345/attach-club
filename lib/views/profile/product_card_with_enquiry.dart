import 'dart:io';

import 'package:attach_club/bloc/profile/profile_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCardWithEnquiry extends StatelessWidget {
  final Product product;
  final bool expanded;
  final String phoneNo;

  const ProductCardWithEnquiry({
    super.key,
    required this.product,
    required this.phoneNo,
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
            Container(
                      height: 0.1974248927 * height,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: product.imageUrl == ""?  Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,

                                child: Container(
                                  color: Colors.white,
                                ),
                              ) : CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ));
                          },
                          errorWidget: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                "Image not found",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          imageUrl: product.imageUrl,
                          
                          fit: BoxFit.fill,
                            placeholder : (context, url) {
                              return Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,

                                child: Container(
                                  color: Colors.white,
                                ),
                              );

                          } ,
                         ),
                      ),
                    ),

            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: (product.imageUrl.isEmpty)
            //       ? SizedBox(height: 0.1974248927 * height)
            //       : Image.network(
            //           product.imageUrl,
            //           height: 0.1974248927 * height,
            //           width: double.infinity,
            //           fit: BoxFit.fill,
            //           loadingBuilder: (context, child, loadingProgress) {
            //             if (loadingProgress == null) {
            //               return child;
            //             } else {
            //               return SizedBox(
            //                 height: 0.1974248927 * height,
            //                 child: const Center(
            //                   child: SizedBox(
            //                     width: 24,
            //                     height: 24,
            //                     child: CircularProgressIndicator(
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             }
            //           },
            //           errorBuilder: (context, error, stackTrace) {
            //             return const Center(
            //               child: Text(
            //                 "Image not found",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            // ),
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
                        "Rs. ${product.price} /-",
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
                        onPressed: () async {
                         String text =
                          "I have an query for \nProduct- ${product.title}\nProduct Description- ${product.description}\nMy Contact No- ${GlobalVariable.userData.phoneNo}\nMy Attach club profile : ${GlobalVariable.metaData.webURL!+ GlobalVariable.userData.username}";

                          var androidUrl = "whatsapp://send?phone=$phoneNo&text=$text";
                          var iosUrl = "https://wa.me/$phoneNo?text=$text}";
                          if (Platform.isIOS) {
                            await launchUrl(Uri.parse(iosUrl));
                          } else {
                            await launchUrl(Uri.parse(androidUrl));
                          }
                        },
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
