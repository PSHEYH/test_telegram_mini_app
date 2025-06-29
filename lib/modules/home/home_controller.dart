import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_telegram_mini_app/modules/modal/modal_controller.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  open(String urlToOpen) {
    final modalController = Get.find<ModalController>();
    modalController.open(urlToOpen);
  }

  openCustomUrl() {
    if (formKey.currentState!.validate()) {
      final modalController = Get.find<ModalController>();
      modalController.open(textEditingController.text);
    }
  }

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введіть url';
    return null;
  }
}
