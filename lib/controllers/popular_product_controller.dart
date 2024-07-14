import 'package:flutter/foundation.dart';
import 'package:flutter_food_delivary/controllers/cart_controller.dart';
import 'package:flutter_food_delivary/data/api/repository/popular_product_repo.dart';
import 'package:flutter_food_delivary/model/products_model.dart';
import 'package:get/get.dart';

import '../utils/alert_widgets.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  int index = 0;

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularproductList => _popularProductList;
  final CartController _cart = Get.find();

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  int get totalItems {
    return _cart.getTotalQuantity;
  }

  void updateIndex(int index) {
    this.index = index;
  }

  void updateCartQuantity(ProductModel product) {
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  // bool _updateQuantity = true;
  // bool get updateQuantity => _updateQuantity;

  void initProduct(ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    bool exist;
    exist = _cart.existInCart(product);
    print("cart exist $exist");

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in the cart is ${_inCartItems.toString()}");
    // get from storage
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  bool checkQuantity(bool isIncrement) {
    if (isIncrement) {
      if ((_inCartItems + _quantity) >= 20) {
        AlertWidget.showSnackbar(
            title: "wrong quantity",
            message: "don't approve quantity $_inCartItems",
            durationSec: 3);
        return false;
      }
    } else {
      if ((_inCartItems + _quantity) <= 0) {
        AlertWidget.showSnackbar(
            title: "wrong quantity",
            message: "don't approve quantity $_inCartItems",
            durationSec: 3);
        return false;
      }
    }
    return true;
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      checkQuantity(true) ? _quantity++ : debugPrint(_quantity.toString());
    } else {
      checkQuantity(false) ? _quantity-- : debugPrint(_quantity.toString());
    }
    update();
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    _isLoaded = false;
    if (response.statusCode == 200) {
      print("got producty list");
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as Iterable);
      _isLoaded = true;
      update();
    } else {
      _isLoaded = true;
      print("didn't got products");
    }
  }
}
