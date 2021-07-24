import 'package:brightness_control/slider.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;

  SliderWidget({
    this.sliderHeight = 90,
    this.max = 10,
    this.min = 0,
    this.fullWidth = true,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .15)),
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
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Color.fromRGBO(251, 49, 36, 1),
          inactiveTrackColor: Color.fromRGBO(191, 191, 191, 1),
          trackHeight: 8.0,
          overlayColor: Colors.white.withOpacity(.0),
          thumbShape: CustomSliderThumbShape(),
        ),
        child: Slider(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ),
    );
  }
}
