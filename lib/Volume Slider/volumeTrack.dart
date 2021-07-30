import 'package:flutter/material.dart';

class DrawTrack extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final Color color;
  final trackShape, indicatorShape, indicatorBorder;
  final double strokewidth;

  DrawTrack({
    this.sliderPosition = 0.0,
    this.dragPercentage = 0.0,
    required this.strokewidth,
    this.color = Colors.black26,
  })  : trackShape = Paint()
          ..color = color
          ..strokeWidth = strokewidth
          ..style = PaintingStyle.fill,
        indicatorShape = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill,
        indicatorBorder = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    _drawLine(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawLine(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset(0, 0) & Size(strokewidth, sliderPosition),
      trackShape,
    );
  }
}
