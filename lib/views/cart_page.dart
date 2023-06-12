import 'package:ecommerce_tutorial/controller/cart_controller.dart';
import 'package:ecommerce_tutorial/controller/order_controller.dart';
import 'package:ecommerce_tutorial/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Consumer<CartController>(
              builder: (context, controller, _) => ElevatedButton(
                  onPressed: () async {
                    await Provider.of<OrderController>(context, listen: false)
                        .order(Order(orderId: "", products: controller.cart));

                    controller.clear();
                  },
                  child: Text('Checkout')),
            ),
            Consumer<CartController>(
              builder: (context, controller, _) =>
                  Text("Total : Rp ${controller.cartTotal}"),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Consumer<CartController>(builder: (context, controller, _) {
                  if (controller.cart.isEmpty) {
                    return Text(
                      'Cart is empty',
                      textAlign: TextAlign.center,
                    );
                  }

                  if (controller.cart.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.cart.length,
                        itemBuilder: (context, index) => Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(controller.cart[index].name),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Rp ${controller.cart[index].price}'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.remove(index);
                                    },
                                    child: Text("Remove"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.red)),
                                  )
                                ],
                              ),
                            ));
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
