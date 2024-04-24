import 'package:flutter/material.dart';

import '../home/widgets/drawer.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final String shippingMethod;

  Order({
    required this.id,
    required this.items,
    required this.shippingMethod,
  });
}

class CartItem {
  final String title;
  final double price;

  CartItem({
    required this.title,
    required this.price,
  });
}

class OrderPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: '123',
      items: [
        CartItem(title: 'Product 1', price: 9.99),
        CartItem(title: 'Product 2', price: 14.99),
      ],
      shippingMethod: 'Pick up',
    ),
    Order(
      id: '456',
      items: [
        CartItem(title: 'Product 3', price: 19.99),
      ],
      shippingMethod: 'Free Delivery',
    ),
  ];

  OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // App Bar
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),

      // Drawer
      drawer: MyDrawer(),
      // Body
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(order: order);
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return ListTile(
                  title: Text(item.title),
                  trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                );
              },
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            const SizedBox(height: 8.0),
            Text(
              'Shipping Method: ${order.shippingMethod}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}