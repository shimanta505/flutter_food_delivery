import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';

import '../model/products_model.dart';
import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final ProductModel product;
  const AppColumn({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        BigText(
          title: product.name!,
          size: Dimensions.font26,
        ),
        // SizedBox(
        //   height: Dimensions.height10,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Wrap(
              children: List.generate(
                product.stars!,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.height15,
                ),
              ),
            ),
            SmallText(title: product.stars!.toString()),
            SmallText(title: "1270 Comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              iconColor: AppColors.iconColor1,
              title: "Normal",
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              iconColor: AppColors.mainColor,
              title: "1.7km",
            ),
            IconAndTextWidget(
              icon: Icons.timer_rounded,
              iconColor: AppColors.iconColor1,
              title: "32min",
            )
          ],
        )
      ],
    );
  }
}
