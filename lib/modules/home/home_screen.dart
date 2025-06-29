import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_telegram_mini_app/modules/modal/components/draggable_modal_widget.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: controller.formKey,
                    child: TextFormField(
                      controller: controller.textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Введіть url',
                        border: OutlineInputBorder(),
                      ),
                      validator: controller.validator,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.openCustomUrl();
                  },
                  child: const Text('Відкрити кастомний url'),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.open('https://google.com');
                  },
                  child: const Text('Відкрити модалку'),
                ),
              ],
            ),
          ),
          DraggableModalWidget()
        ],
      ),
    );
  }
}
