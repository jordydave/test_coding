import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/cart_page.dart';
import 'package:test/pages/home_page.dart';
import 'package:test/pages/splash_page.dart';
import 'package:test/providers/cart_provider.dart';
import 'package:test/providers/product_provider.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}
