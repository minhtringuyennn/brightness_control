import 'package:brightness_control/Volume%20Slider/customTrack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSlider extends StatefulWidget {
  final double width;
  final double height;

  const CustomSlider({Key? key, this.width = 100, this.height = 300})
      : super(key: key);
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  //Offset location = Offset(0.0, 0.0);
  RxDouble dragPosition = 0.0.obs;
  RxDouble dragPercentage = 100.0.obs;

  void _onDragUpdate(DragUpdateDetails update) {
    if (update.localPosition.dy > widget.height)
      dragPosition.value = widget.height;
    else
      dragPosition.value = update.localPosition.dy;

    if (update.localPosition.dy < 0) dragPosition.value = 0;

    dragPosition.value = double.parse(dragPosition.toStringAsFixed(1));
    dragPercentage.value = (1 - (dragPosition / widget.height)) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.width * .1),
                color: Colors.grey[100],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.width * .1),
              child: Container(
                height: widget.height,
                width: widget.width,
                child: Obx(
                  () => CustomPaint(
                    painter: DrawTrack(
                      sliderPosition: dragPosition.value,
                      stroke_width: widget.width,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              height: widget.height - dragPosition.value - 10,
              child: Text(
                '${dragPercentage.round()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        onVerticalDragUpdate: (update) {
          setState(() => _onDragUpdate(update));
        },
      ),
    );
  }
}
