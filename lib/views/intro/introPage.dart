
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bottomTabBar/BottomTabBar.dart';
import '../home/homePage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/productTest.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay rectangle
          Container(
            color: Colors.black.withOpacity(0.4), // Adjust opacity and color as needed
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
          // Add other widgets on top of the background and overlay
          Container (
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,  // Make the text come from the bottom of the screen
              children: [
                const Text(
                  'Welcome to NemoStore! ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  ' The home for a fashionista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // Get Started Button
                const SizedBox(height: 80),
                InkWell(  // make the container clickable
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BottomTabBar(selectedIndex: 0))   // Navigate to homepage screen
                    );
                  },
                  child: Container(
                    width: 193,
                    height: 53,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(29.50),   // Make the border radius
                    ),
                    child: Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.18, color: Colors.white),    // add border side width 1.18
                          borderRadius: BorderRadius.circular(29.50),     // make it radius
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
