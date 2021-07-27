import 'package:flutter/material.dart';

class DrawTrack extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final Color color;
  final trackShape, indicatorShape, indicatorBorder;
  final double stroke_width;

  DrawTrack({
    this.sliderPosition = 0.0,
    this.dragPercentage = 0.0,
    required this.stroke_width,
    this.color = Colors.black26,
  })  : trackShape = Paint()
          ..color = color
          ..strokeWidth = stroke_width
          ..style = PaintingStyle.fill,
        indicatorShape = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill,
        indicatorBorder = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    //_drawAnchor(canvas, size);
    _drawLine(canvas, size);
    //_drawIndicator(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  /* Draw components
  void _drawAnchor(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width * 0, size.height * 1/2), 7.5, trackShape);
    canvas.drawCircle(Offset(size.width * 1, size.height * 1/2), 7.5, trackShape);
  }*/
  void _drawLine(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset(0, 0) & Size(stroke_width, sliderPosition),
      trackShape,
    );
  }

  /*void _drawIndicator(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(0, sliderPosition),
      15.0,
      indicatorBorder,
    );
    canvas.drawCircle(
      Offset(0, sliderPosition),
      12.0,
      indicatorShape,
    );
  }*/
}
