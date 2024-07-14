import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivary/routes/route_helper.dart';
import 'package:flutter_food_delivary/utils/app_constants.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/app_cart.dart';
import 'package:flutter_food_delivary/widget/app_icon.dart';
import 'package:flutter_food_delivary/widget/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../../utils/app_colors.dart';
import '../../../widget/app_column.dart';
import '../../../widget/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularproductList[pageId];
    Get.find<PopularProductController>().initProduct(product);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // popular food image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.popularFoodimgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_IMG_URL +
                        product.img!),
                  ),
                ),
              ),
            ),
            // icons
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: Dimensions.iconSize24,
                      color: Colors.black,
                      grade: 25,
                      weight: 1,
                    ),
                  ),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return InkWell(
                        onTap: () async {
                          await Get.toNamed(RouteHelper.getCartListPage());
                          print("returned");
                          controller.updateCartQuantity(product);
                        },
                        child: AppCart(cartItems: controller.totalItems),
                      );
                    },
                  ),
                ],
              ),
            ),
            // details container
            Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodimgSize - Dimensions.height20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radious20),
                    topRight: Radius.circular(Dimensions.radious20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      product: product,
                    ), // REQUIRED

                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    BigText(title: "Introduce"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                          text: product.description!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (poppularProduct) {
            print("set changed");
            return Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
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
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radious20),
                      color: Colors.yellow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => poppularProduct.setQuantity(false),
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        BigText(title: poppularProduct.inCartItems.toString()),
                        InkWell(
                          onTap: () {
                            poppularProduct.setQuantity(true);
                            print("tapped");
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      poppularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radious20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        title: "10 Items Add to cart",
                        color: AppColors.screenModeText(),
                        size: Dimensions.font18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget customBadges(int totalItem) {
    return badges.Badge(
      badgeContent: BigText(title: totalItem.toString()),
      showBadge: true,
      position: badges.BadgePosition.topStart(),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.white,
      ),
      badgeAnimation: const badges.BadgeAnimation.slide(
          toAnimate: true,
          loopAnimation: true,
          animationDuration: Duration(milliseconds: 500)),
      child: AppIcon(icon: Icons.shopping_cart_outlined),
    );
  }
}
