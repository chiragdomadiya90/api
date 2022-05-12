import 'dart:ui';
import 'package:get/get.dart';

class MyController extends GetxController {
  void changeLanguage(var p1, var p2) {
    var locale = Locale(p1, p2);
    Get.updateLocale(locale);
  }
}
