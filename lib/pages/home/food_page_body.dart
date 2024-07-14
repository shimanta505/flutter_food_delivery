import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/controllers/recomended_product_controller.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:flutter_food_delivary/utils/dimensions.dart';
import 'package:flutter_food_delivary/widget/icon_and_text_widget.dart';
import 'package:flutter_food_delivary/widget/popular_food_animation.dart';
import 'package:flutter_food_delivary/widget/small_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widget/big_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  // int index = 0;
  // int count = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("building popular page body");
    return Column(
      children: [
        // slider section
        const PopularFoodAnimationWithDots(),

        //dots section

        //popular text
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            children: [
              BigText(
                title: "popular",
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              BigText(
                title: '.',
                color: Colors.white24,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(
                title: "Food pairing",
              ),
              // list of foods and images
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        // RECOMENDED PRODUCTS LIST

        GetBuilder<RecomendedProductController>(builder: (recomendedProduct) {
          return recomendedProduct.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recomendedProduct.recomendedproductList.length,
                  itemBuilder: (context, index) {
                    var products =
                        recomendedProduct.recomendedproductList[index];
                    return GestureDetector(
                      onTap: () =>
                          Get.toNamed(RouteHelper.getrecommendedFood(index)),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                          bottom: Dimensions.height10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: Dimensions.listViewImageSize,
                              width: Dimensions.listViewImageSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radious30,
                                ),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_IMG_URL +
                                        products.img!,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: Dimensions.width10),
                                child: Container(
                                  height: Dimensions.listViewImageSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radious20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radious20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BigText(title: products.name!),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      SmallText(
                                          title:
                                              "with chinese charectaristics"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
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
                                            title: "32mi",
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                ); //end
        })
      ],
    );
  }
}

Widget dummyText() => const Text(
    "we can do anything in this world without knowing any thing this would be a favour for us"
    " what can we prove by your self not evewry time we can prove the same thing "
    "over and over we are missing everything what sshoud we do now"
    "flutter is a powerful language its supports android and ios and other multi platform"
    "education is a bullshit its just a waste of time we need to be carefull we cannot do anything"
    "without knoiwing anything this could be your last warning nothing can change your faith"
    "you have to work hard for your destiny never go for other moments no one can handle your problem"
    "  your time my money my effort your money"
    "rfjgjjddfjkkjgfdkjg dfjjkjkddfkrerfgo djdjdkdgkj gjdnjncmkjkgncxv djgnnvdgn cvgjdgnjnvdg "
    "kmdfkmd dfvjedndjfnjv gfdjvjdgjv djnejnv edfgjjdjd dgdjgkjd dgjvnjmg vjvngvg dvdjndj"
    " gownlop power comes from other system this is importent for other persons  "
    "god will save us from other demons sake our faith no one can do this thing with our "
    "presents it is importent to compliment others with same value nothing "
    "what will god do after my failior my faith is on my hand ");
