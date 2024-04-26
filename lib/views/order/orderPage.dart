import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../home/models/product.dart';
import '../home/widgets/drawer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static String baseUrl = "https://cms.istad.co";

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('My Order',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
        ),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            if (value.orderList.isEmpty)
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    'assets/images/no_cart.json',
                    width: 200,
                    height: 200,
                  ),
                ),
              )
            else
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 9,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      itemCount: value.orderList.length,
                      itemBuilder: (context, index) {
                        // get product from cart
                        final Datum order = value.orderList[index];

                        final String title = order.attributes!.title!.toString();
                        final String price = order.attributes!.price!.toString();

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                'Price: \$$price',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}