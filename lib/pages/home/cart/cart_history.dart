import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/controllers/cart_controller.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/app_constants.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/cart_model.dart';
import '../../../widget/big_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int>? cartItemsPerOrder = {};

    for (var element in getCartHistoryList) {
      if (cartItemsPerOrder.containsKey(element.time)) {
        cartItemsPerOrder.update(element.time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(element.time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    int listConter = 0;
    List<int> itemsPerOrder = cartOrderTimeToList();
    List<String> timesPerOrder = cartItemsPerOrderToList();

    return Scaffold(
      body: Column(
        children: [
          // custom AppBar
          Container(
            height: 100,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(bottom: Dimensions.height20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BigText(
                    title: "Cart History",
                    color: Colors.white,
                    size: Dimensions.font20,
                  ),
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                  ),
                ]),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: ListView.builder(
                itemCount: cartItemsPerOrder.length,
                itemBuilder: (_, index) {
                  print("index cart history $index");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (() {
                        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
                            .parse(timesPerOrder[index]); //check
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
                        var outputDate = outputFormat.format(inputDate);

                        print(
                            "storage date   ${getCartHistoryList[index].time!}");
                        return BigText(
                          title: outputDate,
                          color: Colors.white,
                        );
                      }()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            children:
                                List.generate(itemsPerOrder[index], (position) {
                              print("position $position");
                              if (listConter < getCartHistoryList.length) {
                                listConter++;
                              }
                              return position <= 2
                                  ? Container(
                                      height: 65,
                                      width: 65,
                                      margin: EdgeInsets.only(
                                          right: Dimensions.width5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radious20 / 2),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstants
                                                  .BASE_URL +
                                              AppConstants.UPLOAD_IMG_URL +
                                              getCartHistoryList[listConter - 1]
                                                  .img!),
                                        ),
                                      ),
                                    )
                                  : Container();
                            }),
                          ),
                          Expanded(
                            child: Container(
                              // height: 80,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SmallText(
                                    title: "Total",
                                    color: AppColors.titleColor,
                                  ),
                                  BigText(
                                    title: "${itemsPerOrder[index]} items",
                                    color: AppColors.textColor,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      var orderTime = cartItemsPerOrderToList();
                                      Map<int, CartModel> moreOrder = {};
                                      for (int i = 0;
                                          i < getCartHistoryList.length;
                                          i++) {
                                        if (getCartHistoryList[i].time ==
                                            orderTime[index]) {
                                          print(
                                              "order matched time is ${orderTime[index]}");
                                          moreOrder.putIfAbsent(
                                            // might have some problem
                                            getCartHistoryList[i].id!,
                                            () => getCartHistoryList[i],
                                          );
                                        }
                                      } // after the loop adding the items to cart
                                      Get.find<CartController>().setItems =
                                          moreOrder;

                                      Get.find<CartController>()
                                          .addToCartList();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width10,
                                          vertical: Dimensions.width5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radious20 / 3),
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.mainColor,
                                          )),
                                      child: SmallText(
                                        title: "one more",
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
