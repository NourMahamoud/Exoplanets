// lib/View/AmateurViewer/AmateurScreen.dart
import 'dart:math';
import 'package:exoplents/View/homePage/HomeScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ModelView/ExploerPageProvider.dart';
import 'ExploerPage.dart';

class AmateurScreen extends StatelessWidget {
  const AmateurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExplorerPageProvider(),
      child: const AmateurPage(),
    );
  }
}

class AmateurPage extends StatelessWidget {
  const AmateurPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<ExplorerPageProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Images/Frame_1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: provider.planets.length == 0 ? Center(child: CircularProgressIndicator()):
            Listener(onPointerSignal: provider.updateZoom,
              child: GestureDetector(
                onPanStart: provider.startDrag,
                onPanUpdate: provider.updateRotation,
                onPanEnd: provider.endDrag,
                onTapDown: (detiles)=>provider.onTapDown(detiles, size, context),
                child: Stack(
                  children: [
                    CustomPaint(
                      size: size,
                      painter: StarFieldPainter(
                        provider.points,
                        provider.angleX,
                        provider.angleY,
                        provider.zoom,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                          size.width * 0.01,
                          0,
                          size.width * 0.01,
                          0,
                        ),
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage('assets/Images/Space_Invaders3_1.png')) ,
                                          borderRadius: BorderRadius.circular(10) )
                                  ),

                                  SizedBox(width: size.width * 0.01),
                                  const Text(
                                    'EX₂O',
                                    style: TextStyle(
                                      fontSize: 60,
                                      color: Colors.white,
                                      fontFamily: 'NASALIZA',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Homescreen())) ;
                                    },
                                    child: const Text('Home', style: TextStyle(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Mission ', style: TextStyle(color: Colors.white)),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Search', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      right: 50,
                      bottom: 100,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              provider.setAssetPath('assets/Data/confirmed_exoplanets_TOI_v2.json');
                              provider.loadData();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff18376b).withOpacity(0.78), // dark blue background
                                foregroundColor: Colors.white, // text color
                                side: const BorderSide(
                                  color: Color(0xFF274472), // light blue border
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                elevation: 1,
                                fixedSize: Size(200, 60)
                            ),
                            child: const Text('TESS',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Anton',
                                    fontSize: 30)),
                          ),
                          SizedBox(height: size.height * 0.01),
                          ElevatedButton(
                            onPressed: () {
                              provider.setAssetPath('assets/Data/confirmed_exoplanets_K2_v2.json');
                              provider.loadData() ;
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff18376b).withOpacity(0.78), // dark blue background
                              foregroundColor: Colors.white, // text color
                              side: const BorderSide(
                                color: Color(0xFF274472), // light blue border
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              elevation: 1,
                              fixedSize: Size(200, 60)
                            ),
                            child: const Text('K2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Anton',
                                    fontSize: 30)),
                          ),
                          SizedBox(height: size.height * 0.01),
                          ElevatedButton(
                            onPressed: () {
                              provider.setAssetPath('assets/Data/confirmed_exoplanets_v2.json');
                              provider.loadData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff18376b).withOpacity(0.78), // dark blue background
                              foregroundColor: Colors.white, // text color
                              side: const BorderSide(
                                color: Color(0xFF274472), // light blue border
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              elevation: 1,
                              fixedSize: Size(200, 60)
                            ),
                            child: const Text('KEPLER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Anton',
                                    fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StarFieldPainter extends CustomPainter {
  final List<List<double>> points;
  final double angleX;
  final double angleY;
  final double zoom;

  StarFieldPainter(this.points, this.angleX, this.angleY, this.zoom);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in points) {
      final rotated = _rotate(p, angleX, angleY);
      final pos = _project(rotated, size.width, size.height, zoom);
      final depth = (600 / (600 + rotated[2])) * 20 * zoom;
      _drawStar(canvas, pos, depth, Colors.yellowAccent, Colors.orangeAccent);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Color glowColor, Color rayColor) {
    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawCircle(center, size * 0.5, glowPaint);

    final rayPaint = Paint()
      ..shader = RadialGradient(
        colors: [rayColor, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: size));

    for (int i = 0; i < 8; i++) {
      double angle = (pi / 4) * i;
      final dx = cos(angle) * size;
      final dy = sin(angle) * size;
      canvas.drawLine(center, center + Offset(dx, dy), rayPaint..strokeWidth = 2);
    }
  }

  List<double> _rotate(List<double> p, double angleX, double angleY) {
    final cosY = cos(angleY), sinY = sin(angleY);
    var x = p[0] * cosY - p[2] * sinY;
    var z = p[0] * sinY + p[2] * cosY;
    var y = p[1];

    final cosX = cos(angleX), sinX = sin(angleX);
    final y2 = y * cosX - z * sinX;
    final z2 = y * sinX + z * cosX;

    return [x, y2, z2];
  }

  Offset _project(List<double> p, double width, double height, double zoom) {
    const double fov = 600;
    final scale = fov / (fov + p[2]);
    final x2d = p[0] * scale * zoom + width / 2;
    final y2d = p[1] * scale * zoom + height / 2;
    return Offset(x2d, y2d);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
