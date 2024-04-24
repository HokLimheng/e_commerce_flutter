import 'package:flutter/material.dart';

import 'check_out_sucess.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedShippingMethod = 'Free Delivery to home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Step 1',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Shipping',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Country',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Street Name',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'City',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',

                ),
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Shipping Method',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildShippingOptionTile(
                title: 'Free Delivery to home',
                subtitle: 'Deliver to home take 3-7 business day',
                price: 0.0,
                isSelected: _selectedShippingMethod == 'Free Delivery to home',
              ),
              _buildShippingOptionTile(
                title: 'Delivery to home',
                subtitle: 'Delivery from 4 to 6 business days',
                price: 9.90,
                isSelected: _selectedShippingMethod == 'Delivery to home',
              ),
              _buildShippingOptionTile(
                title: 'Fast Delivery',
                subtitle: 'Delivery from 2 to 3 business days',
                price: 9.90,
                isSelected: _selectedShippingMethod == 'Fast Delivery',
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      minimumSize: const Size(203, 48),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => OrderCompletedPage())   // Navigate to homepage screen
                      );
                    },
                    child: const Text('Proceed the order', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'ProductSans',
                    ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShippingOptionTile({
    required String title,
    required String subtitle,
    required double price,
    required bool isSelected,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        price == 0.0 ? 'Free' : '\$${price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onTap: () {
        setState(() {
          _selectedShippingMethod = title;
        });
      },
    );
  }


}

