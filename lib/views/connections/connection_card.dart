import 'package:flutter/material.dart';

class ConnectionCard extends StatelessWidget {
  final List<Widget> actions;

  const ConnectionCard({
    super.key,
    this.actions = const[],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nishant Singh",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Text(
                      "UI/UX Designer",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    )
                  ],
                )
              ],
            ),
            Row(
              children: actions,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
        )
      ],
    );
  }
}
