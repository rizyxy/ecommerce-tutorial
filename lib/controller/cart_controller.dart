import 'dart:convert';

import 'package:ecommerce_tutorial/model/product.dart';
import 'package:flutter/cupertino.dart';

class CartController extends ChangeNotifier {
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  int get cartTotal {
    return cart.fold(
        0, (previousValue, element) => previousValue + element.price);
  }

  void add(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void remove(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _cart = [];
    notifyListeners();
  }
}
