import 'package:get/get.dart';
import 'package:test_telegram_mini_app/modules/modal/modal_controller.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<ModalController>(ModalController());
  }
}
