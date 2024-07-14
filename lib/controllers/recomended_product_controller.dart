import 'package:flutter_food_delivary/data/api/repository/recomended_product_repo.dart';
import 'package:get/get.dart';

import '../model/products_model.dart';
import '../utils/dimensions.dart';

class RecomendedProductController extends GetxController {
  final RecomendedProductRepo recomendedProductRepo;
  RecomendedProductController({required this.recomendedProductRepo});
  var currpageValue = 0.0.obs;
  RxDouble scaleFactor = 0.8.obs;
  double height = Dimensions.pageViewContainer; //recomended
  RxInt index = 0.obs;

  List<dynamic> _recomendedProductList = [];
  List<dynamic> get recomendedproductList => _recomendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecomendedProductList() async {
    Response response = await recomendedProductRepo.getRecomendedProductList();

    _isLoaded = false;
    if (response.statusCode == 200) {
      print("got producty list");
      _recomendedProductList = [];
      _recomendedProductList
          .addAll(Product.fromJson(response.body).products as Iterable);
      _isLoaded = true;
      print(_recomendedProductList);
      update();
    } else {
      _isLoaded = true;
      print("didn't got products");
    }
  }
}
