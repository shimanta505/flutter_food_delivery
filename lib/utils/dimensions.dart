import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;

  static double pageView = screenHeight / 2.30; // screenHeight / 2.64;

  static double pageViewContainer = screenHeight / 3.84; // screenHeight / 3.84;
  static double pageViewTextContainer =
      screenHeight / 5.0; // screenHeight / 7.03;

  static double height5 = screenHeight / 147.6; // screenHeight / 168.8;
  static double height10 = screenHeight / 73.8; // screenHeight / 84.4;
  static double height15 = screenHeight / 49.2; // screenHeight / 56.27;
  static double height20 = screenHeight / 37; // screenHeight / 42.2;
  static double height30 = screenHeight / 24.6; // screenHeight / 28.13;
  static double height40 = screenHeight / 18.45; // screenWidth / 18;
  static double height45 = screenHeight / 16.4; // screenHeight / 18.76;
  static double height70 = screenHeight / 10.5; // screenHeight / 18.76;
  static double height120 = screenHeight / 6.15; // screenHeight / 6.15;
  static double height300 = screenHeight / 2.46; // screenHeight / 18.76;

  static double width5 = screenWidth / 78.6; // screenWidth / 168.8;
  static double width10 = screenWidth / 40; // screenWidth / 84.4;
  static double width15 = screenWidth / 26.2; // screenWidth / 56.27;
  static double width20 = screenWidth / 20; // screenWidth / 42.2;
  static double width30 = screenWidth / 13.1; // screenWidth / 28.13;
  static double width45 = screenWidth / 8.8; // screenWidth / 18.76;
  // screenWidth / 18.76;
  static double width250 = screenWidth / 3.3; // screenWidth / 18.76;

  static double radious5 = screenHeight / 168.8; // screenHeight / 168.8;
  static double radious20 = screenHeight / 42.2; // screenHeight / 42.2;
  static double radious30 = screenHeight / 28.13; // screenHeight / 28.13;

// font size
  static double font14 = screenHeight / 52.7;
  static double font18 = screenHeight / 41; // screenHeight / 42.2;
  static double font20 = screenHeight / 36.9; // screenHeight / 42.2;
  static double font26 = screenHeight / 28.3; // screenHeight / 42.2;

  // text widget height
  static double textHeight150 = screenHeight / 4.92;

  // icon size
  static double iconSize24 = screenHeight / 35.17; // screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75; // screenHeight / 52.75;

  //icon container
  static double iconContainer =
      ((screenWidth * 0.1) + (screenHeight * 0.1)) / 2.5;

  // list view size
  static double listViewImageSize = screenWidth / 3.25; // screenWidth / 3.25;
  static double listViewTextConstSize = screenWidth / 3.9; // screenWidth / 3.9;

  //popular food image size
  static double popularFoodimgSize = screenHeight / 2.2;

  //recomended food bottom nav bar height
  static double bottomNavBar220 = 150;
}
