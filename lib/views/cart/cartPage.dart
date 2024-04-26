import 'package:e_commerce/views/cart/check_out.dart';
import 'package:e_commerce/views/home/models/product.dart';
import 'package:e_commerce/views/home/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../home/widgets/drawer.dart';

class CartPage extends StatefulWidget {
  var order;


  CartPage({super.key, required this.order});

  static String baseUrl = "https://cms.istad.co";

  @override
  State<CartPage> createState() => _CartPageState();
}



class _CartPageState extends State<CartPage> {

  void removeFromCart(Datum cart, BuildContext context) {

    // get access to cart
    final newCart = context.read<Product>();

    // remove product
    newCart.removeFromCart(cart);
  }

  void clearCart(){


    final cart = context.read<Product>();

    cart.clearProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
        ),
        drawer: const MyDrawer(),
        body: Column(
          children: [
           if(value.cart.isEmpty)
             Expanded(
               child: Center(
                 child: Lottie.asset('assets/images/no_cart.json',
                   width: 200,
                   height: 200,
                 ),
               ),
             )
             else
             Expanded(
               child: ListView.builder(
                 itemCount: value.cart.length,
                 itemBuilder: (context, index) {
                   // get product from cart
                   final Datum cart = value.cart[index];

                   final String title = cart.attributes!.title!.toString();

                   final String price = cart.attributes!.price!.toString();


                   var image = '${CartPage.baseUrl}${cart.attributes!.thumbnail!.data!.attributes!.url!}';

                   return Container(
                     // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                     margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),

                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.4),
                             spreadRadius: 1,
                             blurRadius: 9,
                             offset: Offset(0, 3),
                           ),
                         ]
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           width: 100,
                           height: 101,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12),
                             image: DecorationImage(
                               fit: BoxFit.cover,
                               image: NetworkImage(image),
                             ),
                           ),
                         ),
                         Expanded(
                           child: Container(
                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                             child: ListTile(
                               title: Text(
                                 title,
                                 style: const TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18
                                 ),
                               ),
                               subtitle: Text(
                                 '\$ $price',
                                 style: TextStyle(color: Colors.grey[700]),
                               ),
                             ),
                           ),
                         ),
                         IconButton(
                           icon: Icon(Icons.delete, color: Colors.grey[700]),
                           onPressed: () {
                             removeFromCart(cart, context);
                           },
                         ),
                       ],
                     ),
                   );
                 },
               ),
             ),

            // Proceed to checkout button
            const SizedBox(height: 2),
            if (value.cart.isNotEmpty) // Check if the cart is not empty
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(203, 48),
                  ),
                  onPressed: () {
                    clearCart();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CheckoutPage()),
                    );
                  },
                  child: const Text(
                    'Proceed to checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'ProductSans',
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