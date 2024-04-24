
import 'package:e_commerce/views/business_owner/businessOwner.dart';
import 'package:e_commerce/views/cart/cartPage.dart';
import 'package:e_commerce/views/profile/profilePage.dart';
import 'package:flutter/material.dart';
import '../../bottomTabBar/BottomTabBar.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}
class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Material(
          color: Colors.white, // Set the background color of the Drawer
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration:  BoxDecoration(
                  color: Color.fromRGBO(120, 184, 192, 0.7), // Set the background color of the UserAccountsDrawerHeader
                ),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      image: NetworkImage("https://th.bing.com/th/id/OIP.6kHMp3QH7uAFyzTbauvJLAHaKe?rs=1&pid=ImgDetMain"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                accountName: const Text('Luffy', style: TextStyle(color: Colors.black),),
                accountEmail: const Text('Luffy@gmail.com', style: TextStyle(color: Colors.black),),
              ),
              // Add your list tiles here
              buildCustomListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BottomTabBar(selectedIndex: 0,))   // Navigate to homepage screen
                  );
                },
                leadingIcon: Icons.home,
                title: 'Homepage',
              ),
              buildCustomListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BottomTabBar(selectedIndex: 1)),  // Navigate to homepage screen
                    );
                  },

                  leadingIcon: Icons.shopping_cart,
                  title: 'Cart'
              ),
              buildCustomListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BottomTabBar(selectedIndex: 2))   // Navigate to homepage screen
                    );
                  },
                  leadingIcon: Icons.shopping_basket_rounded,
                  title: 'My Order'
              ),
              buildCustomListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BottomTabBar(selectedIndex: 3))   // Navigate to homepage screen
                    );
                  },
                  leadingIcon: Icons.person,
                  title: 'My Profile'
              ),
              const ListTile(
                title: Text('OTHER', style: TextStyle(fontSize: 14),),
              ),
              buildCustomListTile(
                  onTap: (){
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BusinessOwner()),   // Navigate to homepage screen
                      );
                  },
                  leadingIcon: Icons.star,
                  title: 'Business Owner'
              ),
              buildCustomListTile(
                  onTap: (){},
                  leadingIcon: Icons.settings,
                  title: 'Setting'
              ),
              buildCustomListTile(
                  onTap: (){},
                  leadingIcon: Icons.mail_outline,
                  title: 'Support Us'
              ),
              buildCustomListTile(
                  onTap: (){},
                  leadingIcon: Icons.expand_circle_down,
                  title: 'About US'
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCustomListTile({
  required VoidCallback? onTap,
  required IconData leadingIcon,
  required String title,
}) {
  return ListTile(
    onTap: onTap,
    leading: Icon(leadingIcon),
    title: Text(title, style: const TextStyle(fontSize: 16),),
  );
}
