import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnalyticsCard extends StatelessWidget {
  final String number;
  final String title;
  final Color numberColor;
  final String assetPath;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.number,
    this.numberColor = Colors.white,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: const Color(0xFF26293B),
          width: 0.4256976744 * width,
          height: 0.4256976744 * width,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0.04651162791 * width,
                    left: 0.04651162791 * width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        number,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: numberColor),
                      ),
                      Text(title),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  assetPath,
                  width: 0.18604651163 * width,
                  height: 0.18604651163 * width,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
