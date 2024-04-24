import 'package:e_commerce/views/profile/paymentPage.dart';
import 'package:e_commerce/views/profile/profileSetting.dart';
import 'package:e_commerce/views/profile/ratingPage.dart';
import 'package:e_commerce/views/profile/voucherPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addressPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              children: [

                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.6kHMp3QH7uAFyzTbauvJLAHaKe?rs=1&pid=ImgDetMain'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                const Text(
                  'johndoe@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileSetting()));
                        },
                  child: Text('Edit Profile'),
                ),
                const SizedBox(height: 10,),
                const Divider(),
                const SizedBox(height: 10,),

                //Menu
                ProfileMenuWidget(title: "Address", icon: Icons.location_on_outlined, endIcon: true,
                  onPress: (){
                    // Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddressPage()),  // Navigate to homepage screen
                    );
                  },
                  textColor: null,),
                ProfileMenuWidget(title: "Payment Method", icon: Icons.payment, endIcon: true,
                  onPress: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const PaymentPage()),  // Navigate to homepage screen
                    );
                  },
                  textColor: null,),
                ProfileMenuWidget(title: "Voucher", icon: Icons.pageview, endIcon: true,
                  onPress: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const VoucherPage()),  // Navigate to homepage screen
                    );
                }, textColor: null,),
                ProfileMenuWidget(title: "Rate this app", icon: Icons.star_border_outlined, endIcon: true,
                  onPress: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const RatingPage()),  // Navigate to homepage screen
                    );
                  },
                  textColor: null,),
                ProfileMenuWidget(title: "Log out", icon: Icons.logout, endIcon: true, onPress: (){}, textColor: Colors.red,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.endIcon,
    required this.onPress,
    required this.textColor
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Icon(icon),
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.apply(color: textColor),),
        trailing: endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(Icons.navigate_next_outlined),
        ):null,
      ),
    );
  }
}


