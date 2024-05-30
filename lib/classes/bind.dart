import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get_p/classes/controller.dart';

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
    Get.lazyPut<Controller2>(() => Controller2());
    Get.lazyPut<Controller3>(() => Controller3());
  }
}