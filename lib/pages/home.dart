import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_p/classes/controller.dart';
import 'package:get_p/data/t_data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Clicks: ${c.count}")),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: TData.trip.length,
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(
                child: Text(TData.trip[index].tripName),
                onPressed: () => Get.to(Other(),arguments: TData.trip[index].tripLocation),
              );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }

}

class Other extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    final String tripLocation = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(tripLocation),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Text("${c.count}"),
      ),
    );
  }
}

