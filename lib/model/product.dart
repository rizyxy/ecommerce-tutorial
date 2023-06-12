import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_tutorial/model/model.dart';

class Product extends Model {
  String id;
  String name;
  String description;
  int price;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price});

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price']);
  }

  static Product fromQuery(QueryDocumentSnapshot e) {
    return Product(
        id: e.get('id'),
        name: e.get('name'),
        description: e.get('description'),
        price: e.get('price'));
  }

  @override
  Map<String, dynamic> toMap() {
    return ({
      'id': id,
      'name': name,
      'description': description,
      'price': price
    });
  }
}
