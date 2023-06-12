import 'package:ecommerce_tutorial/model/order.dart';
import 'package:ecommerce_tutorial/model/product.dart';
import 'package:ecommerce_tutorial/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder(
                  stream: OrderRepository.orderStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Text(
                          "You haven't ordered anything yet",
                          textAlign: TextAlign.center,
                        );
                      }

                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((e) => Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(e.id),
                                        StreamBuilder(
                                            stream: OrderRepository.orders
                                                .doc(e.id)
                                                .collection('orderDetails')
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: snapshot
                                                        .data!.docs
                                                        .map((e) =>
                                                            Text(e.get('name')))
                                                        .toList());
                                              }

                                              return CircularProgressIndicator();
                                            })
                                      ],
                                    ),
                                  ))
                              .toList(),
                        );
                      }
                    }

                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      )),
    );
  }
}
