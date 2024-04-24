import 'package:e_commerce/views/profile/widgets/addressBox.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              AddressBox(
                locationName: 'Home',
                icon: Icons.work_history_outlined,
                sendTo: 'Office',
                address: 'SBI Building, Street 3, Software Park',
              ),
              SizedBox(height: 20),
              AddressBox(
                locationName: 'Home',
                icon: Icons.home,
                sendTo: 'Home',
                address: 'SBI Building, Street 3, Software Park',
              ),
              const SizedBox(height: 300),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(79, 152, 146, 1),
                  minimumSize: const Size(203, 48),
                ),
                onPressed: (){},
                child: const Text('Add new address', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'ProductSans',
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
