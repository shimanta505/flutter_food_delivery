import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivary/routes/route_helper.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/app_constants.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/app_cart.dart';
import 'package:flutter_food_delivary/widget/app_icon.dart';
import 'package:flutter_food_delivary/widget/big_text.dart';
import 'package:flutter_food_delivary/widget/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../../controllers/recomended_product_controller.dart';

class RecomendedFoodDetails extends StatefulWidget {
  final int pageId;
  const RecomendedFoodDetails({super.key, required this.pageId});

  @override
  State<RecomendedFoodDetails> createState() => _RecomendedFoodDetailsState();
}

class _RecomendedFoodDetailsState extends State<RecomendedFoodDetails> {
  bool safeAreaTop = true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // creating a product instance for multiple use
    var product = Get.find<RecomendedProductController>()
        .recomendedproductList[widget.pageId];
    //  initializeing popularProductController to controll our views
    Get.find<PopularProductController>().initProduct(product);

    return ColorfulSafeArea(
      color: Colors.transparent,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              expandedHeight: Dimensions.height300,
              toolbarHeight: Dimensions.iconContainer + Dimensions.height40,
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.clear,
                    ),
                  ),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return InkWell(
                        onTap: () async {
                          await Get.toNamed(RouteHelper.getCartListPage());
                          print("returned");
                          controller.updateCartQuantity(product);
                          // setState(() {});
                        },
                        child: AppCart(cartItems: controller.totalItems),
                      );
                    },
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: Dimensions.height5,
                    bottom: Dimensions.height15,
                  ),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radious20),
                      topRight: Radius.circular(Dimensions.radious20),
                    ),
                  ),
                  child: Center(
                    child: BigText(
                      title: product.name!,
                      size: Dimensions.font26,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD_IMG_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  right: Dimensions.width20,
                  left: Dimensions.width20,
                ),
                padding: EdgeInsets.only(bottom: Dimensions.height20),
                child: ExpandableTextWidget(
                  text: product.description!,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Container(
              height: Dimensions.bottomNavBar220,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radious20),
                topRight: Radius.circular(Dimensions.radious20),
              )),
              child: SingleChildScrollView(
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      child: Container(
                        height: Dimensions.bottomNavBar220,
                        color: Get.isDarkMode
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width15 * 2.5,
                            right: Dimensions.width15 * 2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.setQuantity(false);
                                print("tapped -- ${controller.quantity}");
                              },
                              child: AppIcon(
                                icon: Icons.remove,
                                backGroundColor: AppColors.mainColor,
                                iconSize: Dimensions.iconSize24,
                              ),
                            ),
                            BigText(
                              title:
                                  "\$ ${product.price!} X ${controller.inCartItems}",
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : AppColors.mainBlackColor,
                              size: Dimensions.font26,
                            ),
                            InkWell(
                              onTap: () {
                                controller.setQuantity(true);
                                print("tapped ++ ${controller.quantity}");
                              },
                              child: AppIcon(
                                icon: Icons.add,
                                backGroundColor: AppColors.mainColor,
                                iconSize: Dimensions.iconSize24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: Dimensions.bottomNavBar220 * 0.40,
                      child: Container(
                        height: Dimensions.height120,
                        width: Get.width,
                        padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Colors.grey.shade700
                              : Colors.grey.shade600,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radious20 * 2),
                            topRight: Radius.circular(Dimensions.radious20 * 2),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10,
                              ),
                              child: AppIcon(
                                icon: Icons.favorite,
                                iconSize: Dimensions.iconSize24,
                                iconColor: AppColors.mainColor,
                              ),
                            ),
                            InkWell(
                              onTap: () => controller.addItem(product),
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: Dimensions.height20,
                                  bottom: Dimensions.height20,
                                  left: Dimensions.width20,
                                  right: Dimensions.width20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radious20),
                                  color: AppColors.mainColor,
                                ),
                                child: BigText(
                                  title:
                                      "${controller.inCartItems} Items Add to cart",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget customText(String text) {
    return Text(
      text,
      style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
    );
  }
}
