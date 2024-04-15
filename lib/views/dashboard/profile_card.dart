import 'package:flutter/material.dart';

import '../../core/components/rating.dart';

class ProfileCard extends StatelessWidget {
  final int selected;
  final String name;
  final String description;
  final String asset;

  const ProfileCard({
    super.key,
    required this.selected,
    required this.name,
    required this.description,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      child: SizedBox(
        width: 0.39069 * width,
        height: 0.2972103004 * height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                asset,
                height: 0.1942060086 * height,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Rating(selected: selected),
          ],
        ),
      ),
    );
  }
}
