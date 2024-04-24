
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowedTextFieldBox extends StatelessWidget {
  // final TextEditingController controller;
  final String hintText;

  const ShadowedTextFieldBox({
    Key? key,
    // required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // Offset to make the shadow appear below
          ),
        ],
      ),
      child: TextField(
        // controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        maxLines: 9,
        maxLength: 50, // Set maximum character limit
      ),
    );
  }
}