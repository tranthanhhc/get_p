import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
}
class Controller2 extends GetxController {
  var count = 2.obs;
  increment() => count++;
}class Controller3 extends GetxController {
  var count = 4.obs;
  increment() => count++;
}