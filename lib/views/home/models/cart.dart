import 'package:e_commerce/views/home/models/product.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier{
  List<Datum> _items = [];

  List<Datum> get items => _items;

  // void addToCart(Datum product, int quantity) {
  //   print('product ${product.attributes!.title.toString()}');
  //   int index = items.indexWhere((item) => item.product.id == product.id);
  //
  //   if (index != -1) {
  //     items[index].quantity += quantity;
  //   } else {
  //     items.add(CartItem(product: product, quantity: quantity));
  //   }
  // }

  // add to cart
  void addToCart(Datum product, int quantity){
    for(int i=0; i < quantity; i++){
      _items.add(product);
    }
    notifyListeners();
  }

  // void removeFromCart(Datum product) {
  //   items.removeWhere((item) => item.product.id == product.id);
  // }

  void clearCart() {
    items.clear();
  }
}

class CartItem {
  Datum product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
