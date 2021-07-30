import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Light Slider/lightSlider.dart';
import 'Volume Slider/volumeController.dart';
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

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Light setting app")),
      body: Center(
        child: ElevatedButton(
          child: Text("Show Setting", style: TextStyle(fontSize: 20)),
          onPressed: () => Get.bottomSheet(
            BuildSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class BuildSheet extends StatelessWidget {
  const BuildSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisabledGlowScroll(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.94,
        minChildSize: 0.93,
        maxChildSize: 0.94,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          padding: EdgeInsets.only(top: 20, right: 25, left: 25),
          child: BuildContent(controller: controller),
        ),
      ),
    );
  }
}

class BuildContent extends StatelessWidget {
  final ScrollController controller;
  final inpController = Get.put(VolumeController());

  BuildContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        BuildTitle(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text("Name room", style: TextStyle(color: Colors.black54)),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a number',
          ),
          controller: inpController.textController,
          onSubmitted: inpController.onUpdate(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LightSlider(),
              SizedBox(width: 50),
              CustomSlider(),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Name light',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.border_color_rounded,
                  size: 22,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DisabledGlowScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
