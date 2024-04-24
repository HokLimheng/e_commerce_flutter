import 'package:e_commerce/views/business_owner/post_products.dart';
import 'package:e_commerce/views/business_owner/update_products.dart';
import 'package:e_commerce/views/home/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../productDetailPage.dart';


class ProductCard extends StatelessWidget {
  ProductCard({
    this.product
  });

  Datum? product;
  static String baseUrl = "https://cms.istad.co";

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>  ProductPage(product: product)),   // Navigate to homepage screen
        );
      },
      child: InkWell(

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
                  child: Image.network(
                    '$baseUrl${product!.attributes!.thumbnail!.data!.attributes!.url!}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(product!.attributes!.title.toString(), maxLines: 1 , style: TextStyle(
                fontSize: 17,
                fontFamily: 'ProductSans',
              ),
              ),
              // const SizedBox(height: 5),
              Text('\$ ${product!.attributes!.price}', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'ProductSans',
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
