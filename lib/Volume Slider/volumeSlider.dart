import 'package:flutter/material.dart';
import 'volumeTrack.dart';

class CustomSlider extends StatefulWidget {
  final double width, height;
  final double position, percentage;
  final ValueChanged<double> onChanged;
  const CustomSlider(
      {Key? key,
      this.height = 300,
      this.width = 100,
      this.position = 0,
      this.percentage = 0,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with AutomaticKeepAliveClientMixin {
  late double position = widget.position;
  late double percentage = widget.percentage;

  @override
  bool get wantKeepAlive => true;

  void _onDragUpdate(DragUpdateDetails update) {
    if (update.localPosition.dy > widget.height)
      position = widget.height;
    else
      position = update.localPosition.dy;
    if (update.localPosition.dy < 0) position = 0;

    setState(() {
      position = double.parse(position.toStringAsFixed(1));
      percentage = double.parse((position / widget.height).toStringAsFixed(2));
      widget.onChanged(percentage);
    });
  }

  @override
  void initState() => super.initState();

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
                  sliderPosition: position,
                  strokewidth: widget.width,
                ),
              ),
            ),

            // Draw percentage
            Positioned(
              height: widget.height - position - 10,
              child: Text(
                //'${textPercent.texttext}',
                '${((1 - percentage) * 100).round()}',
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
