import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/pages/home/food_page_body.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/big_text.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';


class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  void initState() {
    // TODO: implement initState
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: Dimensions.height15, top: Dimensions.height45),
            padding: EdgeInsets.only(
                left: Dimensions.height20, right: Dimensions.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      title: "Bangladesh",
                      color: AppColors.mainColor,
                      size: Dimensions.font26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          title: "phulpur",
                          size: Dimensions.font20,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded),
                      ],
                    )
                  ],
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: Dimensions.height45,
                      width: Dimensions.width45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
