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
        duration: const Duration(milliseconds: 1500), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }
 
 Align getAalignWidget(double x, double y, String name, String desc, String asset){
  return Align(
          alignment: Alignment(x, y),
          child: SizedBox(
            height: 100.0,
            width: 100.0,
            child: Column(
              children: [
                Image.asset(asset,
                height: 58.0,
                width: 58.0,
                ),
                Text(name, style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold ),),
                Text(desc, style: const TextStyle(fontSize: 10.0),),
              ],
            ),
          ), );
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
        
        getAalignWidget(-0.7, -0.6, "Sanaya", "I am an artist", "assets/images/person1.png"),
        getAalignWidget(0.7, -0.3, "Amyra", "I am a shopkeeper", "assets/images/person2.png"),
        getAalignWidget(-0.7, 0.6, "Vikas", "I am a developer", "assets/images/person3.png"),
        getAalignWidget(0.9, 0.6, "Neel", "I am a chemist", "assets/images/person4.png"),
        
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
