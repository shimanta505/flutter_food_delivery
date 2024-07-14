import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/popular_product_controller.dart';
import '../model/products_model.dart';
import '../routes/route_helper.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/dimensions.dart';
import 'app_column.dart';

class PopularFoodAnimationWithDots extends StatefulWidget {
  const PopularFoodAnimationWithDots({
    super.key,
  });

  @override
  State<PopularFoodAnimationWithDots> createState() =>
      _PopularFoodAnimationWithDotsState();
}

class _PopularFoodAnimationWithDotsState
    extends State<PopularFoodAnimationWithDots> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  double currpageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;
  int position = 0;
  @override
  initState() {
    _pageController.addListener(() {
      setState(() {
        currpageValue = _pageController.page!;
      });

      // _productController.setCurrentPageValue(_pageController.page!);
    });

    // changePages();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: GetBuilder<PopularProductController>(
            // id: "currentPage",
            init: PopularProductController(popularProductRepo: Get.find()),
            builder: (popularProducts) {
              // print("updated");
              return popularProducts.isLoaded
                  ? SizedBox(
                      height: Dimensions.pageView,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: popularProducts.popularproductList.length,
                        itemBuilder: (_, index) {
                          //  print(index);

                          return buildPageItem(
                            index,
                            popularProducts.popularproductList[index],
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: Dimensions.pageView,
                      width: double.maxFinite,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      ),
                    );
            },
          ),
        ),
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularproductList.isEmpty
                  ? 1
                  : popularProducts.popularproductList.length,
              position: currpageValue.floor(),
              onTap: (int position) async {
                int duration =
                    (((position - this.position) / 2) * 120).abs().toInt();
                print("duration  $duration");
                duration == 0 ? duration = 100 : duration;
                await _pageController.animateToPage(position,
                    duration: Duration(milliseconds: (duration)),
                    curve: Curves.linear);
                this.position = position;
              },
              decorator: DotsDecorator(
                color: Colors.orange,
                activeColor: Colors.amber,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          },
        )
      ],
    );
  }

  void changePages() async {
    bool loop = true;

    while (loop) {
      _pageController.jumpToPage(2);
    }
  }

  buildPageItem(int index, ProductModel popularProduct) {
    var matrix = Matrix4.identity();
    if (index == currpageValue.floor()) {
      //
      double currScale = 1 - (currpageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      //
    } else if (index == currpageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currpageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currpageValue.floor() - 1) {
      var currScale = 1 - (currpageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width5,
                right: Dimensions.width5,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(Dimensions.radious30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_IMG_URL +
                      popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radious30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: Dimensions.radious5,
                    offset: const Offset(0, 5),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    top: Dimensions.height10),
                child: AppColumn(
                  product: popularProduct,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
