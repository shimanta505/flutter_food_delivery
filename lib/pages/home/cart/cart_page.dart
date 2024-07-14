import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/controllers/cart_controller.dart';
import 'package:flutter_food_delivary/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivary/controllers/recomended_product_controller.dart';
import 'package:flutter_food_delivary/routes/route_helper.dart';
import 'package:flutter_food_delivary/utils/alert_widgets.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/app_constants.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/app_icon.dart';
import 'package:flutter_food_delivary/widget/big_text.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    Get.find<CartController>().getCartData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 2,
              right: Dimensions.width20,
              left: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              )),
          Positioned(
            top: Dimensions.height20 * 5,
            right: Dimensions.width20,
            left: Dimensions.width20,
            bottom: 0,
            child: GetBuilder<CartController>(
              builder: (cartItems) {
                return ListView.builder(
                  itemCount: cartItems.getItems.length,
                  itemBuilder: ((context, index) {
                    var cartList =
                        cartItems.getItems[index]; // list of cart items
                    return Container(
                      margin: EdgeInsets.all(Dimensions.height5),
                      height: Dimensions.height20 * 5,
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              var popularProductIndex =
                                  Get.find<PopularProductController>()
                                      .popularproductList
                                      .indexWhere((element) =>
                                          element.id == cartList.id);

                              if (popularProductIndex >= 0) {
                                Get.toNamed(RouteHelper.getPopularFood(
                                    popularProductIndex));
                              } else {
                                var recomendedFoodIndex =
                                    Get.find<RecomendedProductController>()
                                        .recomendedproductList
                                        .indexWhere((element) =>
                                            element.id == cartList.id);

                                if (recomendedFoodIndex >= 0) {
                                  AlertWidget.showSnackbar(
                                      title: "History Product",
                                      message:
                                          "Product review isn't available for history product",
                                      durationSec: 2);
                                  Get.toNamed(RouteHelper.getrecommendedFood(
                                      recomendedFoodIndex));
                                } else {
                                  AlertWidget.showSnackbar(
                                      title: "History Product",
                                      message:
                                          "Product review isn't available for history product",
                                      durationSec: 5);
                                }
                              }
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: Dimensions.width20),
                              width: Dimensions.width20 * 5,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.blue,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${AppConstants.BASE_URL}${AppConstants.UPLOAD_IMG_URL}${cartList.img!}"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            // margin: EdgeInsets.only(left: Dimensions.width20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                BigText(
                                  title: cartList.name!,
                                  size: Dimensions.font20,
                                  color: AppColors.screenModeText(),
                                ),
                                SmallText(title: "spicy"),
                                Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  fit: StackFit.loose,
                                  children: [
                                    // price
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: BigText(
                                        title: "\$ ${cartList.price!}",
                                        size: Dimensions.font20,
                                        color: Colors.red,
                                      ),
                                    ),

                                    // set cart items
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(Dimensions.height5),
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? Colors.grey.shade800
                                                : Colors.grey.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Dimensions.radious20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () => cartItems.addItem(
                                                  cartList.product!, -1),
                                              child: Icon(
                                                Icons.remove,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width5,
                                            ),
                                            BigText(
                                              title:
                                                  cartList.quantity!.toString(),
                                              size: Dimensions.font18,
                                              color: AppColors.screenModeText(),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width5,
                                            ),
                                            InkWell(
                                              onTap: () => cartItems.addItem(
                                                  cartList.product!, 1),
                                              child: Icon(
                                                Icons.add,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartList) {
          return Container(
            height: Dimensions.height120,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radious20 * 2),
                  topRight: Radius.circular(Dimensions.radious20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   width: Dimensions.width5,
                // ),
                Container(
                  width: Dimensions.width250,
                  margin: EdgeInsets.only(left: Dimensions.width10),
                  padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radious20),
                      color: Colors.transparent),
                  child: Center(
                    child: Text(
                      cartList.totalAmount.toString(),
                      style: TextStyle(
                        color: AppColors.screenModeText(),
                        fontSize: Dimensions.font26,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartList.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radious20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      title: "${cartList.getTotalQuantity.toString()} checkout",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
