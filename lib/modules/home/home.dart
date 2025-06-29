library home;

import 'package:get/get.dart';
import 'package:test_telegram_mini_app/modules/home/home_binding.dart';
import 'package:test_telegram_mini_app/modules/home/home_screen.dart';

final pages = [
  GetPage(
      name: HomeScreen.routeName,
      page: () => HomeScreen(),
      transition: Transition.fade,
      binding: HomeBinding()),
];
