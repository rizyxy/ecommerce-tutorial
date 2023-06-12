import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_tutorial/model/product.dart';
import 'package:ecommerce_tutorial/model/order.dart' as order;

class OrderRepository {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference orders = firestore.collection('orders');

  static Stream<QuerySnapshot> orderStream = orders.snapshots();

  static Future<void> add(order.Order order) async {
    await orders.add(order.toMap()).then((value) {
      orders.doc(value.id).update({'id': value.id});

      for (var product in order.products) {
        orders.doc(value.id).collection('orderDetails').add(product.toMap());
      }
    });
  }
}
