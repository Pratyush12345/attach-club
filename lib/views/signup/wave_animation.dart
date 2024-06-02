import 'dart:math';
import 'package:flutter/material.dart';

class CircleWaveRoute extends StatefulWidget {
  const CircleWaveRoute({super.key});

  @override
  CircleWaveRouteState createState() => CircleWaveRouteState();
}

class CircleWaveRouteState extends State<CircleWaveRoute>
    with TickerProviderStateMixin {
  
  double waveRadius = 0.0;
  double waveGap = 60.0;
  late Animation<double> _animation;
  late AnimationController controller;
  late Animation<double> _imageanimation;
  late AnimationController imagecontroller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        reverseDuration: const Duration(milliseconds: 1500) ,
        duration: const Duration(milliseconds: 1500), vsync: this);

    imagecontroller = AnimationController(
      reverseDuration: const Duration(milliseconds: 2500) ,
        duration: const Duration(milliseconds: 1500), vsync: this);    

    controller.forward();

    imagecontroller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    imagecontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        imagecontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        imagecontroller.forward();
      }
    });
  }

   
 Widget getAalignWidget(double x, double y, String name, String desc, String asset, int n, int m){
  return AnimatedBuilder(
    animation: imagecontroller,
    builder: (context, widget) {
      return Align(
              alignment: Alignment(x, y),
              child: SizedBox(
                height: 100.0,
                width: 100.0,
                child: Transform.translate(
                  offset: Offset(n*_imageanimation.value * x, m*_imageanimation.value  *y) ,
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
                ),
              ), );
    }
  );
 }
  @override
  Widget build(BuildContext context) {
    _animation = Tween(begin: 0.0, end: waveGap, ).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });
     
    //  _imageanimation = Tween(begin: 0.0, end: 3.0 ).animate(imagecontroller)
    //   ..addListener(() {
        
    //   });

     _imageanimation = CurvedAnimation(parent: imagecontroller, curve: Curves.fastOutSlowIn, reverseCurve: Curves.fastEaseInToSlowEaseOut )..addListener(() { });

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
                              color: Color(0xFF181B2F),
                              shape: BoxShape.circle,
                              // image: DecorationImage(
                                
                              //   image: AssetImage("assets/images/splash.png"),
                              //   fit: BoxFit.cover,
                              // )
              
            ),
            child: Image.asset("assets/images/splash.png",
            width: 70, 
            height: 70,
            fit: BoxFit.contain,
            ),
          ),
          
        ),
        
        getAalignWidget(-0.7, -0.6, "Sanaya", "I am an artist", "assets/images/person1.png", 14, 18),
        getAalignWidget(0.7, -0.3, "Amyra", "I am a shopkeeper", "assets/images/person2.png", 18, -13),
        getAalignWidget(-0.7, 0.6, "Vikas", "I am a developer", "assets/images/person3.png", -8, 15),
        getAalignWidget(0.9, 0.6, "Neel", "I am a chemist", "assets/images/person4.png", 14, 14),
        
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    imagecontroller.dispose();
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
