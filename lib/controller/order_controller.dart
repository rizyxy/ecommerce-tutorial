import 'package:ecommerce_tutorial/model/order.dart';
import 'package:ecommerce_tutorial/model/product.dart';
import 'package:ecommerce_tutorial/repository/order_repository.dart';
import 'package:flutter/cupertino.dart';

class OrderController extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> order(Order order) async {
    await OrderRepository.add(order);
  }
}
