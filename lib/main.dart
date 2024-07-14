import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recomended_product_controller.dart';
import 'helper/dependencies/dependencies.dart' as dep;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
  mapData();
}

Future<void> loadData() async {
  print("getting the data ****  ${DateTime.now()}");
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<RecomendedProductController>().getRecomendedProductList();
  // Get.find<CartController>().getCartData();
  print("got the data ****  ${DateTime.now()}");
}

void mapData() {
  var map = {
    'name': "shimanta",
    'age': "23",
    'details': [
      {
        'work': "software enginear",
        'passion': "implement new things",
      },
      {
        'work': "software enginear",
        'passion': "implement new things",
      },
      {
        'work': "software enginear",
        'passion': "implement new things",
      }
    ],
  };

  print(map['details']);
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.height);
    print(Get.width);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.dark(useMaterial3: true),
      // initialBinding: Dependencies(),
      initialRoute: RouteHelper.getSplashPage(),
      onInit: () => loadData(),
      getPages: RouteHelper.routes,
      smartManagement: SmartManagement.onlyBuilder,
    );
  }
}
