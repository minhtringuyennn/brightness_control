import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VolumeController extends GetxController {
  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  //static VolumeController get i => Get.find();
  var textController = TextEditingController();
  RxDouble dragPosition = 150.0.obs;
  RxDouble dragPercentage = 50.0.obs;

  onUpdate() {
    if (_isNumeric(textController.text)) {
      dragPercentage.value = double.parse(textController.text);
      dragPosition.value = 300 * (1 - (dragPercentage.value) / 100);
    }
  }
}
