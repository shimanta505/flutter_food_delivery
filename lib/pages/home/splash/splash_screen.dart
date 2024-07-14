import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/routes/route_helper.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../../controllers/popular_product_controller.dart';
import '../../../controllers/recomended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;

  Future<void> loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecomendedProductController>().getRecomendedProductList();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 4),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            ScaleTransition(
              scale: animation,
              child: Center(
                child: Image.asset(
                  "assets/images/food-logo.png",
                ),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Center(
              child: Text(
                "The Best Food",
                style: TextStyle(
                    fontSize: Dimensions.font26,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
