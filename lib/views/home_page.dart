import 'package:ecommerce_tutorial/controller/cart_controller.dart';
import 'package:ecommerce_tutorial/model/product.dart';
import 'package:ecommerce_tutorial/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              StreamBuilder(
                  stream: ProductRepository.productStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Text(
                          "No Products Available",
                          textAlign: TextAlign.center,
                        );
                      }

                      if (snapshot.data!.docs.isNotEmpty) {
                        List<Product> _products = snapshot.data!.docs
                            .map((e) => Product.fromQuery(e))
                            .toList();

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: _products.length,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () => Provider.of<CartController>(
                                          context,
                                          listen: false)
                                      .add(_products[index]),
                                  child: Card(
                                    child: Column(
                                      children: <Widget>[
                                        Text(_products[index].name),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'Rp ${_products[index].price.toString()}')
                                      ],
                                    ),
                                  ),
                                ));
                      }
                    }

                    return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
