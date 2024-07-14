import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/app_icon.dart';
import 'package:flutter_food_delivary/widget/big_text.dart';

class AppCart extends StatelessWidget {
  final int cartItems;
  const AppCart({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppIcon(
          icon: Icons.shopping_cart_outlined,
          iconSize: Dimensions.iconSize24,
        ),
        cartItems >= 1
            ? Positioned(
                right: 0,
                top: 0,
                child: AppIcon(
                  icon: Icons.circle,
                  size: Dimensions.height20,
                  iconColor: Colors.transparent,
                  backGroundColor: AppColors.mainColor,
                ),
              )
            : Container(),
        cartItems >= 1
            ? Positioned(
                right: cartItems < 10 ? 6 : 2,
                top: 1,
                child: Center(
                  child: BigText(
                    title: cartItems.toString(),
                    color: Colors.black,
                    size: 14,
                  ),
                ))
            : Container(),
      ],
    );
  }
}
