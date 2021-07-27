import 'package:brightness_control/Light%20Slider/customTrack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LightSlider extends StatefulWidget {
  final double width;
  final double height;

  const LightSlider({Key? key, this.width = 100, this.height = 300})
      : super(key: key);
  @override
  _LightSliderState createState() => _LightSliderState();
}

class _LightSliderState extends State<LightSlider> {
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
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(
                  Radius.circular((widget.width * .1)),
                ),
                gradient: new LinearGradient(
                  colors: [
                    const Color.fromRGBO(255, 121, 0, 1),
                    const Color.fromRGBO(255, 220, 67, 1),
                    const Color.fromRGBO(100, 193, 255, 1),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 0.4, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            Positioned(
              left: widget.width / 2,
              child: Container(
                height: widget.height,
                width: widget.width,
                child: Obx(
                  () => CustomPaint(
                    painter: DrawLightTrack(
                      sliderPosition: dragPosition.value,
                      stroke_width: 8,
                      color: Color.fromRGBO(182, 182, 182, 1),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              height: widget.height - dragPosition.value + 10,
              width: widget.width,
              right: widget.width - 32,
              child: Text(
                '${dragPercentage.round()}',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
