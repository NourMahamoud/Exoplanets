import 'dart:async';
import 'dart:math';
import 'package:exoplents/Model/PlanetModel.dart';
import 'package:exoplents/utlis/customwdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Discoveryourexo extends StatefulWidget {
  final  PlanetModel planet;

   Discoveryourexo({super.key, required this.planet});

  @override
  State<Discoveryourexo> createState() => _DiscoveryourexoState(planet);
}

class _DiscoveryourexoState extends State<Discoveryourexo> {
  final  PlanetModel planet;

  _DiscoveryourexoState(this.planet);

  double angle = 0;
  double velocity = 0.001;
  double a = 350;
  double b = 400;
  double inclination = 0.3;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      setState(() {
        angle += velocity; 
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final headingFontSize = (width / 12).clamp(28.0, 96.0);
    final subtitleFontSize = (width / 28).clamp(14.0, 32.0);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/Frame_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  SizedBox(width: width * 0.3),
                  Column(
                    children: [
                      Text(
                        'PLANET NAME',
                        style: TextStyle(
                          fontSize: headingFontSize * 0.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 0.45 * width,
                    height: 0.9 * height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade50.withOpacity(0.1),
                    ),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text('Star Name : ${planet.star_name}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),

                       Text('Orbit Period : ${planet.orbital_period}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                       Text('Temperature : ${planet.temperature}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                       Text('Transit Duration : ${planet.transit_duration}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                       Text('Disposition :${planet.koi_disposition}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Planet Radius : ${planet.planet_radius}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Planet To Star Radius Ratio : ${planet.star_planet_radius_ratio}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Stellar Radius : ${planet.stellar_radius}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Stellar Temperature : ${planet.stellar_temperature}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Transit Depth : ${planet.transit_depth}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        Text('Distance : ${planet.distance}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 0.45 * width,
                    height: 0.9 * height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double simWidth = constraints.maxWidth;
                        double simHeight = constraints.maxHeight;
                        double centerX = simWidth / 2;
                        double centerY = simHeight / 2;
                        double px = centerX + a * cos(angle);
                        double py = centerY + b * sin(angle);
                        double cosInc = cos(inclination);
                        double sinInc = sin(inclination);
                        double dx = (px - centerX) * cosInc -
                            (py - centerY) * sinInc;
                        double dy = (px - centerX) * sinInc +
                            (py - centerY) * cosInc;
                        px = centerX + dx;
                        py = centerY + dy;
                        return Container(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: OrbitPainter(
                                    center: Offset(centerX, centerY),
                                    a: a,
                                    b: b,
                                    inclination: inclination,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: centerX - 50,
                                top: centerY - 50,
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Flutter3DViewer(src: 'assets/Sun.glb'),
                                ),
                              ),


                              Positioned(
                                left: px - 20,
                                top: py - 20,
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child:
                                  Flutter3DViewer(src: 'assets/Planet.glb'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// رسام المدار
class OrbitPainter extends CustomPainter {
  final Offset center;
  final double a; // نصف المحور الأكبر
  final double b; // نصف المحور الأصغر
  final double inclination;

  OrbitPainter({
    required this.center,
    required this.a,
    required this.b,
    this.inclination = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.save();

    // ميل المدار
    canvas.translate(center.dx, center.dy);
    canvas.rotate(inclination);
    canvas.translate(-center.dx, -center.dy);

    // رسم المدار (إهليلج)
    Rect rect = Rect.fromCenter(center: center, width: 2 * a, height: 2 * b);
    canvas.drawOval(rect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
