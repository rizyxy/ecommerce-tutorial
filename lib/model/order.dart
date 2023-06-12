import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_tutorial/model/model.dart';
import 'package:ecommerce_tutorial/model/product.dart';

class Order extends Model {
  String orderId;
  List<Product> products;

  Order({required this.orderId, required this.products});

  static Order fromQuery(QueryDocumentSnapshot e) {
    return Order(
        orderId: e.get('orderId'), products: jsonDecode(e.get('products')));
  }

  @override
  Map<String, dynamic> toMap() {
    return ({'id': orderId});
  }
}
