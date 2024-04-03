import 'dart:math';
import 'package:flutter/material.dart';

class CircleWaveRoute extends StatefulWidget {
  const CircleWaveRoute({super.key});

  @override
  CircleWaveRouteState createState() => CircleWaveRouteState();
}

class CircleWaveRouteState extends State<CircleWaveRoute>
    with SingleTickerProviderStateMixin {
  double waveRadius = 0.0;
  double waveGap = 60.0;
  late Animation<double> _animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween(begin: 0.0, end: waveGap).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });

    return Stack(
      children: [
        CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: CircleWavePainter(waveRadius),
        ),
        Center(
          child: Container(
            width: 79,
            height: 79,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CircleWavePainter extends CustomPainter {
  final double waveRadius;
  var wavePaint;

  CircleWavePainter(this.waveRadius) {
    wavePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double maxRadius = hypot(centerX, centerY);

    var currentRadius = waveRadius;
    while (currentRadius < maxRadius) {
      double opacity = (maxRadius - currentRadius) / maxRadius;
      wavePaint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, wavePaint);
      currentRadius += 60.0;
    }
  }

  @override
  bool shouldRepaint(CircleWavePainter oldDelegate) {
    return oldDelegate.waveRadius != waveRadius;
  }

  double hypot(double x, double y) {
    return sqrt(x * x + y * y);
  }
}
