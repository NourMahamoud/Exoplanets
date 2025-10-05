import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:provider/provider.dart';
import '../../ModelView/ExploerPageProvider.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExplorerPageProvider(),
      child: const Exploerpage(),
    );
  }
}

class Exploerpage extends StatefulWidget {
  const Exploerpage({super.key});

  @override
  State<Exploerpage> createState() => _ExploerpageState();
}

class _ExploerpageState extends State<Exploerpage> {
  double angle = 0;
  double velocity = 0.02;
  double a = 2000;
  double b = 1200;
  double inclination = 0.3;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
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

  List<double> _rotate3D(List<double> point, double angleX, double angleY) {
    double x = point[0], y = point[1], z = point[2];
    double x1 = x * cos(angleY) - z * sin(angleY);
    double z1 = x * sin(angleY) + z * cos(angleY);
    double y1 = y * cos(angleX) - z1 * sin(angleX);
    double z2 = y * sin(angleX) + z1 * cos(angleX);
    return [x1, y1, z2];
  }

  Offset _project(List<double> p, Offset center, double zoom) {
    const double fov = 600;
    double scale = fov / (fov + p[2]);
    double x2d = p[0] * scale * zoom + center.dx;
    double y2d = p[1] * scale * zoom + center.dy;
    return Offset(x2d, y2d);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<ExplorerPageProvider>(
        builder: (context, p, child) {
          double simWidth = 900.0;
          double simHeight = 900.0;
          double centerX = simWidth / 2;
          double centerY = simHeight / 2;
          Offset simCenter = Offset(centerX, centerY);

          // Planet position
          double theta = angle;
          double px = a * cos(theta);
          double py = b * sin(theta) * cos(inclination);
          double pz = b * sin(theta) * sin(inclination);

          final planet3D = _rotate3D([px, py, pz], p.angleX, p.angleY);
          final planet2D = _project(planet3D, simCenter, p.zoom);

          final sun3D = _rotate3D([0, 0, 0], p.angleX, p.angleY);
          final sun2D = _project(sun3D, simCenter, p.zoom);

          return Listener(
            onPointerSignal: p.updateZoom,
            child: GestureDetector(
              onPanEnd: p.endDrag,
              onPanStart: p.startDrag,
              onPanUpdate: p.updateRotation,
              child: Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/Images/Frame_1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: CustomPaint(
                                painter: OrbitPainter(
                                  center: simCenter,
                                  a: a,
                                  b: b,
                                  inclination: inclination,
                                  angleX: p.angleX,
                                  angleY: p.angleY,
                                  zoom: p.zoom,
                                ),
                              ),
                            ),
                            Positioned(
                              left: sun2D.dx - 50,
                              top: sun2D.dy - 50,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Flutter3DViewer(src: 'assets/Sun.glb'),
                              ),
                            ),
                            Positioned(
                              left: planet2D.dx - 30,
                              top: planet2D.dy - 30,
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Flutter3DViewer(src: 'assets/Planet.glb'),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrbitPainter extends CustomPainter {
  final Offset center;
  final double a;
  final double b;
  final double inclination;
  final double angleX;
  final double angleY;
  final double zoom;

  OrbitPainter({
    required this.center,
    required this.a,
    required this.b,
    this.inclination = 0,
    required this.angleX,
    required this.angleY,
    required this.zoom,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    List<Offset> orbitPoints = [];
    for (int i = 0; i <= 360; i += 3) {
      double theta = i * pi / 180;
      double x = a * cos(theta);
      double y = b * sin(theta) * cos(inclination);
      double z = b * sin(theta) * sin(inclination);

      final rotated = _rotate3D([x, y, z], angleX, angleY);
      final projected = _project(rotated, center, zoom);
      orbitPoints.add(projected);
    }

    for (int i = 0; i < orbitPoints.length - 1; i++) {
      canvas.drawLine(orbitPoints[i], orbitPoints[i + 1], paint);
    }
  }

  List<double> _rotate3D(List<double> point, double angleX, double angleY) {
    double x = point[0], y = point[1], z = point[2];
    double x1 = x * cos(angleY) - z * sin(angleY);
    double z1 = x * sin(angleY) + z * cos(angleY);
    double y1 = y * cos(angleX) - z1 * sin(angleX);
    double z2 = y * sin(angleX) + z1 * cos(angleX);
    return [x1, y1, z2];
  }

  Offset _project(List<double> p, Offset center, double zoom) {
    const double fov = 600;
    double scale = fov / (fov + p[2]);
    double x2d = p[0] * scale * zoom + center.dx;
    double y2d = p[1] * scale * zoom + center.dy;
    return Offset(x2d, y2d);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
