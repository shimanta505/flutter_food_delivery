import 'package:get/get.dart';

import '../utils/dimensions.dart';

class BuildPageItemController extends GetxController {
  var currpageValue = 0.0.obs;
  RxDouble scaleFactor = 0.8.obs;
  double height = Dimensions.pageViewContainer;
  RxInt index = 0.obs;
}
