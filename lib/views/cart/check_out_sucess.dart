import 'package:flutter/material.dart';

class OrderCompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 120.0,
              color: Colors.green,
            ),
            SizedBox(height: 24.0),
            Text(
              'Order Completed',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Thank you for your purchase!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'You can view your order in the \'My Orders\'.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            Text('Section', style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
            ),


            // Continue shopping button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(203, 48),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Continue Shopping', style: TextStyle(
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
    );
  }
}