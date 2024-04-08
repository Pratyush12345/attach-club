import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 0.0268 * height),
      child: SizedBox(
        width: 0.888372093 * width,
        height: 0.1030042918 * height,
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(
              left: 0.04186 * width,
              top: 0.01716 * height,
              bottom: 0.01716 * height,
            ),
            child: Row(
              children: [
                Container(
                  width: 0.1488372093 * width,
                  height: 0.1488372093 * width,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nishant Singh",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "+91 8279492748",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
