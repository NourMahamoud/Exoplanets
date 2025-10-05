import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum SystemMode { star, planet, mission }

class ShowSystem extends ChangeNotifier {
  double _angleX = 0;
  double _angleY = 0;
  double _zoom = 1.0;
  Offset? _lastDrag;

  // ===== New: Current system mode =====
  SystemMode _mode = SystemMode.star;

  // ===== Getters =====
  double get zoom => _zoom;
  double get angleX => _angleX;
  double get angleY => _angleY;
  SystemMode get mode => _mode;

  // ===== Setters =====
  void setMode(SystemMode newMode) {
    _mode = newMode;
    notifyListeners();
  }

  // ====== Zoom handling ======
  void updateZoom(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      _zoom = (_zoom - event.scrollDelta.dy * 0.005).clamp(0.3, 10.0);
      notifyListeners();
    }
  }

  // ====== Rotation handling ======
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
}
