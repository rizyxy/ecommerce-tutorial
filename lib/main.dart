import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_tutorial/controller/cart_controller.dart';
import 'package:ecommerce_tutorial/firebase_options.dart';
import 'package:ecommerce_tutorial/views/cart_page.dart';
import 'package:ecommerce_tutorial/views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartController())],
      child: MaterialApp(
        routes: {
          '/home': (context) => HomePage(),
          '/cart': (context) => CartPage()
        },
        initialRoute: '/home',
      ),
    );
  }
}
