import 'package:flutter/foundation.dart';
import 'package:flutter_food_delivary/model/products_model.dart';
import 'package:flutter_food_delivary/utils/alert_widgets.dart';
import 'package:get/get.dart';

import '../data/api/repository/cart_repo.dart';
import '../model/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  @override
  void onInit() {
    // TODO: implement onInit

    getCartData();
    cartRepo.addToCartList(getItems);
    super.onInit();
  }

  int get totalAmount {
    int amount = 0;
    _items.forEach((key, value) {
      amount += (value.quantity! * value.price!);
    });

    print(amount);
    return amount;
  }

  int get totalQuantity {
    int amount = 0;
    _items.forEach((key, value) {
      amount += (value.quantity!);
    });

    print(amount);
    return amount;
  }

  List<CartModel> get getItems {
    return _items.entries
        .map(
          (e) => e.value,
        )
        .toList();
  }

  int get getTotalQuantity {
    int quantity = 0;
    _items.forEach((key, value) {
      quantity += value.quantity!;
    });
    return quantity;
  }

  set setCart(List<CartModel> list) {
    storageItems = list;
    for (var element in storageItems) {
      _items.putIfAbsent(element.id!, () => element);
      print(element.id);
    }
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  void addItem(ProductModel product, int quantity) {
    int totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        debugPrint(
            "adding item to cart id is ${product.id} quantity is ${value.quantity} length is ${_items.length}}");
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: totalQuantity,
          isExist: true,
          time: DateTime.now().toString(),
          typeId: value.typeId,
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          debugPrint("adding item to cart id is ${product.id} quantity is"
              " $quantity length is ${_items.length}}");
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            typeId: product.typeId,
            product: product,
          );
        });
      } else {
        AlertWidget.showSnackbar(
            title: "not possible",
            message: "you have to add atleast 1 item to the cart",
            durationSec: 5);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id!) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }
}
