
import 'package:e_commerce/views/home/models/product.dart';
import 'package:e_commerce/views/home/viewmodels/product_vm.dart';
import 'package:e_commerce/views/intro/introPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Product(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ProductSans',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          )
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const IntroPage(),

    );
  }
}
