import 'package:flutter/material.dart';

class ProductCardWithEnquiry extends StatelessWidget {
  const ProductCardWithEnquiry({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      color: const Color(0xFF26293B),
      child: SizedBox(
        width: 0.5651162791 * width,
        height: 0.3605150215 * height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/lady.jpg",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Horai CTC Tea",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Horai Assam CTC Tea available flipkart and amazon",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    "Rs 450/Kg",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF4285F4),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(4),
                      ),
                      fixedSize:
                      Size(0.5046511628 * width, 32),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Query",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
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
