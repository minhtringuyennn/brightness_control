import 'package:flutter/material.dart';

class DrawLightTrack extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final Color color;
  final trackShape, indicatorShape, indicatorBorder;
  final double stroke_width;

  DrawLightTrack({
    this.sliderPosition = 0.0,
    this.dragPercentage = 0.0,
    required this.stroke_width,
    this.color = Colors.black,
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
    _drawActiveLine(canvas, size);
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
      Offset(-stroke_width / 2, 0) & Size(stroke_width, sliderPosition),
      trackShape,
    );
  }

  void _drawActiveLine(Canvas canvas, Size size) {
    final shape = Paint()
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..color = Colors.red;

    final path1 = Path();
    path1.moveTo(0, size.height);
    path1.lineTo(-3, size.height);
    path1.lineTo(-5, sliderPosition);
    path1.lineTo(0, sliderPosition);

    path1.close();
    canvas.drawPath(path1, shape);

    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.lineTo(3, size.height);
    path2.lineTo(5, sliderPosition);
    path2.lineTo(0, sliderPosition);

    path2.close();
    canvas.drawPath(path2, shape);

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
  }
}
