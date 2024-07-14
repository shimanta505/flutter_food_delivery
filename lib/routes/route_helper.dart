import 'package:flutter_food_delivary/pages/home/cart/cart_page.dart';
import 'package:flutter_food_delivary/pages/home/food/popular_food_detail.dart';
import 'package:flutter_food_delivary/pages/home/food/recomended_food_details.dart';
import 'package:flutter_food_delivary/pages/home/home_page.dart';
import 'package:flutter_food_delivary/pages/home/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = '/';
  static const String popularFoods = '/popular-food';
  static const String recommendedFoods = '/recommended-food';
  static const String cartPage = '/cart-page';

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId) => "$popularFoods?pageId=$pageId";
  static String getrecommendedFood(int pageId) =>
      "$recommendedFoods?pageId=$pageId";
  static String getCartListPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.leftToRight),
    GetPage(
      name: popularFoods,
      page: () {
        var pageId = Get.parameters["pageId"];
        return PopularFoodDetail(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: recommendedFoods,
      page: () {
        var pageId = Get.parameters["pageId"];

        return RecomendedFoodDetails(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
    ),
  ];
}
