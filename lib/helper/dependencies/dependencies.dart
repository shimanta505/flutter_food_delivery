import 'package:flutter_food_delivary/controllers/cart_controller.dart';
import 'package:flutter_food_delivary/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivary/controllers/recomended_product_controller.dart';
import 'package:flutter_food_delivary/data/api/api_client.dart';
import 'package:flutter_food_delivary/data/api/repository/cart_repo.dart';
import 'package:flutter_food_delivary/data/api/repository/popular_product_repo.dart';
import 'package:flutter_food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/repository/recomended_product_repo.dart';

class Dependencies implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    //local database
    final sharedPreferences = SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);

    // api client

    Get.lazyPut(() => ApiClient(
        appBaseUrl: AppConstants
            .BASE_URL)); //http://mvs.bslmeiyu.com/api/v1/products/popular

    // REPOSITORYS
    Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => RecomendedProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()), fenix: true);

    // CONTROLLERS
    Get.lazyPut(
        () => RecomendedProductController(recomendedProductRepo: Get.find()),
        fenix: true);
    Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()),
        fenix: true);

    Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
  }
}

Future<void> init() async {
  final sharedPreference = await SharedPreferences.getInstance();
  // sharedPreference.clear();

  Get.lazyPut(() => sharedPreference);
  //  API CLIENT
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants
          .BASE_URL)); //http://mvs.bslmeiyu.com/api/v1/products/popular

  // REPOSITORYS
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecomendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()), fenix: true);

  // CONTROLLERS
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecomendedProductController(recomendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
