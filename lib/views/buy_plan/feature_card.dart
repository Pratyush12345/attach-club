import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subTitle;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFE976),
            Color(0xFFFFD16A),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 0.05348837209 * width,
          right: 0.03655913978 * width,
          top: 0.01502145923*height,
          bottom: 0.01502145923*height,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 27,
              height: 27,
              child: Image.asset("assets/images/premium_yellow.png"),
            ),
            SizedBox(width: 0.03655913978 * width),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      color: Color(0xFF373A4B),
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
