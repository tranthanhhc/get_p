import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_p/pages/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Obx(() => Text("${controller.count}")),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ));
}