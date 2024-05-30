import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_p/classes/bind.dart';
import 'package:get_p/classes/controller.dart';

class Home2 extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetX<Controller>(
                builder: (_) => Text(
                  'clicks: ${controller.count}',
                )),
            Obx(() => Text(
              'clicks: ${controller.count}',
            )),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                Get.to(Second(),binding: SampleBind());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Second extends StatelessWidget {
  final Controller ctrl = Get.find();

  @override
  Widget build(context){
    return Scaffold(body: Center(child: Text("${ctrl.count}")));
  }
}

