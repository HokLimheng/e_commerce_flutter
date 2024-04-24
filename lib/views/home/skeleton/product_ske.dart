import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const  EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(top: 5),
        height: 350,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          // color: Colors.greenAccent
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 290,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                  'assets/images/productTest.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text('Long Sleeve Dress', maxLines: 1 , style: TextStyle(
              fontSize: 17,
              fontFamily: 'ProductSans',
            ),
            ),
            // const SizedBox(height: 5),
            const Text('\$ 45.00', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'ProductSans',
            ),
            ),
          ],
        ),

      ),
    );
  }
}
