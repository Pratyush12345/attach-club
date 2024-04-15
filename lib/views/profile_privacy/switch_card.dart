import 'package:flutter/material.dart';

class SwitchCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final void Function(bool) onChange;
  
  const SwitchCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      color: (value)?const Color(0xFF4285F4):const Color(0xFF26293B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0128 * height),
        child: Row(
          children: [
            SizedBox(
              width: 0.0372 * width,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              activeTrackColor: const Color(0xFF181B2F),
              activeColor: Colors.white,
              inactiveTrackColor: const Color(0xFF2A2D40),
              inactiveThumbColor: const Color(0xffc4c4c4).withOpacity(0.6),
              value: value,
              onChanged: onChange,
            ),
          ],
        ),
      ),
    );
  }
}
