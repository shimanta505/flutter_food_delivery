import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:get/get.dart';

class AlertWidget {
  static void showSnackbar(
      {required String title,
      required String message,
      required int durationSec}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.mainColor,
      duration: Duration(seconds: durationSec),
    );
  }
}
