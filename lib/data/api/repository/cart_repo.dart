import 'dart:convert';

import 'package:flutter_food_delivary/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];

    var time = DateTime.now().toString();
    // makeing objects to string value
    // sharedPreferences only accept string value
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    List<CartModel> cartList = [];

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      // storig the string list to the carts
      // like the below
      /*
      [
        { // DEMO
          "id": 3,
          "name": "Chinese Side",
          "product": {
            "id": 3,
            "name": "Chinese Side",
          }
        }
      ]; */
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    for (var element in carts) {
      // now converting list of string to a map data format by jsonDecode
      // then converting map data to CartMpdel object and storeing to cartList
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  void addToCartHistoryList() {
    print("cart length ${cart.length}");
    for (var element in cart) {
      cartHistory.add(element);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print(sharedPreferences
        .getStringList(AppConstants.CART_HISTORY_LIST)!
        .length);
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> cartListHistory = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void removeCart() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
