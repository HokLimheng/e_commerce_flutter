
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../addressPage.dart';

class AddressBox extends StatefulWidget {
  final String locationName;
  final IconData icon;
  final String sendTo;
  final String address;

  const AddressBox({
    Key? key,
    required this.locationName,
    required this.icon,
    required this.sendTo,
    required this.address,
  }) : super(key: key);

  @override
  _AddressBoxState createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected = value ?? false;
                    });
                  },
                ),
                Icon(
                  widget.icon,
                  size: 40,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send to',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.sendTo,
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.address,
                style: const TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
