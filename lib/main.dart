import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Light Slider/lightSlider.dart';
import 'Volume Slider/volumeSlider.dart';

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primarySwatch: Colors.red,
        ),
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double newPer = 0.50, newPos = 150;
  final _textController = TextEditingController();

  void _onTextSubmitted(String text) {
    try {
      newPer = double.parse((1 - double.parse(text) / 100).toStringAsFixed(2));
      newPos = double.parse((newPer * 300).toStringAsFixed(1));
    } on Exception catch (e) {
      print(e);
    }

    setState(() {});
  }

  void _onSliderChanged(double value) {
    _textController.text = ((1 - value) * 100).round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Name Light', style: TextStyle(fontSize: 20)),
          bottom: TabBar(
            tabs: [Tab(text: 'Text Field View'), Tab(text: 'Slider View')],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a number',
                  ),
                  controller: _textController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                  onSubmitted: _onTextSubmitted,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LightSlider(),
                  SizedBox(width: 20),
                  CustomSlider(
                    key: UniqueKey(),
                    position: newPos,
                    percentage: newPer,
                    onChanged: _onSliderChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
