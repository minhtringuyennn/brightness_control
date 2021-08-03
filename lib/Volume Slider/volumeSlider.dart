import 'package:flutter/material.dart';
import 'volumeTrack.dart';

class CustomSlider extends StatefulWidget {
  final double width = 100;
  final double height = 300;

  final String percentage;

  const CustomSlider({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double dragPercentage = 50.0;
  double dragPosition = 150.0;

  void _onDragUpdate(DragUpdateDetails update) {
    dragPosition = update.localPosition.dy;

    if (dragPosition > widget.height) dragPosition = widget.height;

    if (update.localPosition.dy < 0) dragPosition = 0;

    dragPosition = double.parse(dragPosition.toStringAsFixed(1));
    dragPercentage = (1 - (dragPosition / widget.height)) * 100;
  }

  @override
  void initState() {
    double _percentage = double.parse(widget.percentage);
    dragPercentage = _percentage;
    dragPosition = 300 * (1 - (dragPercentage / 100));

    print("widget init $dragPercentage");

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomSlider oldWidget) {
    double _percentage = double.parse(widget.percentage);
    dragPercentage = _percentage;
    dragPosition = 300 * (1 - (dragPercentage / 100));

    print("widget pass $dragPercentage, at $dragPosition");

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.width * .1),
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Track layout
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(color: Colors.grey[100]),
            ),

            // Draw track
            Container(
              height: widget.height,
              width: widget.width,
              child: CustomPaint(
                painter: DrawTrack(
                  sliderPosition: dragPosition,
                  strokewidth: widget.width,
                ),
              ),
            ),

            // Draw percentage
            Positioned(
              height: widget.height - dragPosition - 10,
              child: Text(
                //'${textPercent.texttext}',
                '${dragPercentage.round()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),

        // Update track
        onVerticalDragUpdate: (update) {
          setState(() => _onDragUpdate(update));
        },
      ),
    );
  }
}
