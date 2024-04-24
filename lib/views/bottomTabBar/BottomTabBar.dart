import 'package:e_commerce/views/order/orderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/views/cart/cartPage.dart';
import 'package:e_commerce/views/home/homePage.dart';
import '../cart/check_out.dart';
import '../profile/profilePage.dart';

class BottomTabBar extends StatefulWidget {
  int selectedIndex = 0;
  BottomTabBar({super.key, required this.selectedIndex});
  @override
  State<BottomTabBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomTabBar> {

  var currentIndex = 0;


  final List<Widget> screens = [
    HomePage(),
    CartPage(order: false,),
    OrderPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index){
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens.elementAt(currentIndex),

        // Bottom Navigator
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 0, blurRadius: 20),
              ],
            ),


            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,

                onTap: (index){
                  setState(() {
                    currentIndex = index;
                  });
                },

                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                iconSize: 25,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_rounded ), label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_basket), label: 'My Order'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile')
                ],
              ),
            )
        )
    );
  }
}
