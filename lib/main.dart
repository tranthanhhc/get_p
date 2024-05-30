import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_navigation/get_navigation.dart';
//import 'package:get_p/classes/bind.dart';
//import 'package:get_p/pages/home.dart';
//import 'package:get_p/pages/home2.dart';
//import 'package:get_p/pages/home_binds.dart';
//import 'package:get_p/pages/home_view.dart';
//import 'dart:ui';
// void main() {
//   runApp(
//        GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         //home: Home(),
//          initialRoute: '/home',
//         getPages: [
//           // GetPage(
//           //     name: '/',
//           //     page: () => const Home(),
//           // ),
//           // GetPage(
//           //   name: '/next_home',
//           //   page: () =>  Home2(),
//           //   binding: SampleBind(),
//           // ),
//           GetPage(
//               name: '/home',
//               page: () => HomeView(),
//               binding: HomeBinding(),
//           ),
//         ],
//       ),
//   );
// }

void main() {
  runApp(GetMaterialApp(
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    defaultTransition: Transition.native, // chuyen trang mac dinh
    translations: MyTranslations(), // chuyen ngu
    locale: const Locale('pt', 'BR'), // ngon ngu
    getPages: [
      //Simple GetPage
      GetPage(name: '/home', page: () => First()),
      // GetPage with custom transitions and bindings
      GetPage(
        name: '/second', // ten router
        page: () => Second(),// trang hien thi
        customTransition: SizeTransitions(), // hieu ung chuyen trang
        binding: SampleBind(), //??
      ),
      // GetPage with default transitions
      GetPage(
        name: '/third',
        transition: Transition.cupertino,
        page: () => Third(),
      ),
    ],
  ));
}
//quản lý bản dịch
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': 'Hello World %s',
    },
    'en_US': {
      'title': 'Hello World from US',
    },
    'pt': {
      'title': 'Olá de Portugal',
    },
    'pt_BR': {
      'title': 'Olá do Brasil',
    },
  };
}
//quản lý trạng thái
class Controller extends GetxController {
  int count = 0;// khởi tao biến
  void increment() { // phương thức xử lý
    count++;
    // use update method to update all count variables
    update();
  }
}
// giao diện đầu tiên
class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.snackbar("Hi", "I'm modern snackbar");
          },
        ),
        title: Text("title".trArgs(['John'])),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<Controller>(
                init: Controller(),
                // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
                builder: (_) => Text(
                  'clicks: ${_.count}',
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16.0,bottom: 16.0),
              child: ElevatedButton(
                child: const Text('Next Route'),
                onPressed: () {
                  Get.toNamed('/second');// chuyen trang su dung toNamed
                },
              ),
            ),
            ElevatedButton(
              child: const Text('Change locale to English'),
              onPressed: () {
                Get.updateLocale(const Locale('en', 'UK'));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.find<Controller>().increment();
          }),
    );
  }
}
// giao diện thứ 2
class Second extends GetView<ControllerX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('second Route'),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Obx(
                    () {
                  print("count1 rebuild");
                  return Text('${controller.count1}');
                },
              ),
              Obx(
                    () {
                  print("count2 rebuild");
                  return Text('${controller.count2}');
                },
              ),
              Obx(() {
                print("sum rebuild");
                return Text('${controller.sum}');
              }),
              Obx(
                    () => Text('Name: ${controller.user.value?.name}'),
              ),
              Obx(
                    () => Text('Age: ${controller.user.value?.age}'),
              ),
              ElevatedButton(
                child: const Text("Go to last page"),
                onPressed: () {
                  Get.toNamed('/third', arguments: 'arguments of second');
                },
              ),
              ElevatedButton(
                child: const Text("Back page and open snackbar"),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'User 123',
                    'Successfully created',
                    icon: Icon(Icons.man),
                    colorText: Colors.yellowAccent,
                  );
                },
              ),
              ElevatedButton(
                child: const Text("Increment"),
                onPressed: () {
                  controller.increment();
                },
              ),
              ElevatedButton(
                child: const Text("Increment"),
                onPressed: () {
                  controller.increment2();
                },
              ),
              ElevatedButton(
                child: const Text("Update name"),
                onPressed: () {
                  controller.updateUser();
                },
              ),
              ElevatedButton(
                child: const Text("Dispose worker"),
                onPressed: () {
                  controller.disposeWorker();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// màn hình thứ 3
class Third extends GetView<ControllerX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.incrementList();
      }),
      appBar: AppBar(
        title: Text("Third ${Get.arguments}"),
      ),
      body: Center(
          child: Obx(() => ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                return Center(child: Text("${controller.list[index]}"));
              }))),
    );
  }
}
//?
class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerX>(() => ControllerX());
  }
}
//lớp đại diện cho user
class User {
  User({this.name = 'Name', this.age = 0});
  String name;
  int age;
}
// chứa các biến , phương thức
class ControllerX extends GetxController {
  final count1 = 0.obs;
  final count2 = 0.obs;
  final list = [56].obs;
  final user = User().obs;

  updateUser() {
    user.update((value) {
      value!.name = 'Jose';
      value.age = 30;
    });
  }

  /// Once the controller has entered memory, onInit will be called.
  /// It is preferable to use onInit instead of class constructors or initState method.
  /// Use onInit to trigger initial events like API searches, listeners registration
  /// or Workers registration.
  /// Workers are event handlers, they do not modify the final result,
  /// but it allows you to listen to an event and trigger customized actions.
  /// Here is an outline of how you can use them:

  /// made this if you need cancel you worker
  late Worker _ever;

  @override
  onInit() { // khởi tạo
    /// Called every time the variable $_ is changed
    _ever = ever(count1, (_) => print("$_ has been changed (ever)"));

    everAll([count1, count2], (_) => print("$_ has been changed (everAll)"));

    /// Called first time the variable $_ is changed
    once(count1, (_) => print("$_ was changed once (once)"));

    /// Anti DDos - Called every time the user stops typing for 1 second, for example.
    debounce(count1, (_) => print("debouce$_ (debounce)"),
        time: const Duration(seconds: 1));

    /// Ignore all changes within 1 second.
    interval(count1, (_) => print("interval $_ (interval)"),
        time: const Duration(seconds: 1));
  }

  int get sum => count1.value + count2.value;

  increment() => count1.value++;

  increment2() => count2.value++;

  disposeWorker() {
    _ever.dispose();
    // or _ever();
  }

  incrementList() => list.add(75 + sum);
}
// animation
class SizeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: curve!,
        ),
        child: child,
      ),
    );
  }
}

