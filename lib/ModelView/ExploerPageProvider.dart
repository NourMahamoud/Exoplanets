// lib/ModelView/ExplorerPageProvider.dart
import 'dart:math';

import 'package:exoplents/Model/PlanetModel.dart';
import 'package:exoplents/Model/dataSource/LocalData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../View/AmateurViewer/DiscoverYourExo.dart';
import '../View/AmateurViewer/ExploerPage.dart';

class ExplorerPageProvider extends ChangeNotifier {
  List<PlanetModel> _planets = [];
  List<String> _stars = [];
  bool _loading = false;
  String? _error;
  final Random _rnd = Random();
  late List<List<double>> _points;
  double _angleX = 0;
  double _angleY = 0;
  double _zoom = 1.0;
  Offset? _lastDrag;
   String assetPath;

  ExplorerPageProvider({
    this.assetPath = 'assets/Data/confirmed_exoplanets_v2.json',
  }) {
    _points = _generateStars(0, radius: 900);
    loadData();
  }
 void  setAssetPath (String path){
    assetPath = path;
    notifyListeners();
 }
  // ====================== Load Data ======================
  Future<void> loadData() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await Localdata().loadJsonAsset(assetPath);
      _planets = response.map((e) => PlanetModel.fromjson(e)).toList();
      _stars = _planets
          .map((p) => p.star_name ?? '')
          .where((s) => s.isNotEmpty)
          .toSet()
          .toList();
      print(planets.length);
      print(stars.length);
      _points = _generateStars(stars.length, radius: 900);
    } catch (e, st) {
      _error = e.toString();
      _planets = [];
      _stars = [];
      if (kDebugMode) {
        print('ExplorerPageProvider.loadData error: $e\n$st');
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ====================== Interaction ======================
  void updateZoom(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      _zoom = (_zoom - event.scrollDelta.dy * 0.01).clamp(0.001, 5.0);
      notifyListeners();
    }
  }

  void updateRotation(DragUpdateDetails details) {
    if (_lastDrag != null) {
      final dx = details.localPosition.dx - _lastDrag!.dx;
      final dy = details.localPosition.dy - _lastDrag!.dy;
      _angleY += dx * 0.01;
      _angleX += dy * 0.01;
      _lastDrag = details.localPosition;
      notifyListeners();
    }
  }

  void startDrag(DragStartDetails details) {
    _lastDrag = details.localPosition;
  }

  void endDrag(DragEndDetails _) {
    _lastDrag = null;
  }

  // ====================== Helpers ======================
  List<List<double>> _generateStars(int count, {double radius = 300}) {
    return List.generate(count, (_) {
      final x = (_rnd.nextDouble() - 0.5) * radius * 2;
      final y = (_rnd.nextDouble() - 0.5) * radius * 1.5;
      final z = (_rnd.nextDouble() - 0.5) * radius * 2;
      return [x, y, z];
    });
  }

  // ====================== Getters ======================
  List<PlanetModel> get planets => _planets;

  List<String> get stars => _stars;

  bool get isLoading => _loading;

  String? get error => _error;

  List<List<double>> get points => _points;

  double get angleX => _angleX;

  double get angleY => _angleY;

  double get zoom => _zoom;

  void onTapDown(TapDownDetails details, Size size, BuildContext context) {
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;
    int? tappedIndex;
    double minDist = 30;

    for (int i = 0; i < _points.length; i++) {
      final rotated = _rotate(_points[i], _angleX, _angleY);
      final pos = _project(rotated, size.width, size.height, _zoom);
      final dist = (Offset(dx, dy) - pos).distance;
      if (dist < minDist) {
        tappedIndex = i;
        minDist = dist;
      }
    }

    if (tappedIndex != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) =>  Discoveryourexo (planet: _planets[tappedIndex!]),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  // ====================== Math Helpers ======================
  List<double> _rotate(List<double> point, double angleX, double angleY) {
    final x = point[0];
    final y = point[1];
    final z = point[2];

    // Rotation around Y-axis
    final x1 = x * cos(angleY) - z * sin(angleY);
    final z1 = x * sin(angleY) + z * cos(angleY);

    // Rotation around X-axis
    final y1 = y * cos(angleX) - z1 * sin(angleX);
    final z2 = y * sin(angleX) + z1 * cos(angleX);

    return [x1, y1, z2];
  }

  Offset _project(List<double> point, double width, double height, double zoom) {
    final perspective = 500.0;
    final scale = perspective / (perspective + point[2]);
    final x2d = point[0] * scale * zoom + width / 2;
    final y2d = point[1] * scale * zoom + height / 2;
    return Offset(x2d, y2d);
  }
}
