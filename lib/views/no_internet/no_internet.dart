import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternet extends StatelessWidget {
  final void Function() onRetry;

  const NoInternet({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 0.3906976744 * width,
                height: 0.3906976744 * width,
                decoration: BoxDecoration(
                  color: const Color(0xFF26293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/svg/no_internet.svg",
                    width: 48,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Please check your internet connection and try again",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D4CF9),
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 32,
                  //   vertical: 16,
                  // ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
