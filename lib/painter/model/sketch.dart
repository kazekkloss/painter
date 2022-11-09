import 'package:flutter/material.dart';
import 'package:paint/painter/config/sketcher.dart';

class Sketch {
  final List<Offset> points;
  final Color color;
  final double width;
  final DrawingMode mode;
  final bool filled;

  Sketch(
      {required this.points,
      required this.color,
      required this.width,
      required this.mode,
      required this.filled});
}
