import 'package:e_commerce/views/business_owner/post_products.dart';
import 'package:e_commerce/views/business_owner/update_products.dart';
import 'package:e_commerce/views/home/models/product.dart';
import 'package:e_commerce/views/home/viewmodels/product_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';


class ProductCardOwner extends StatelessWidget {
  ProductCardOwner({
    this.product
  });

  Datum? product;
  static String baseUrl = "https://cms.istad.co";
  var productViewModel = ProductViewModel();

  @override
  Widget build(BuildContext context) {

    return InkWell(
        onLongPress: (){
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you sure to remove this Product?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ChangeNotifierProvider(
                      create: (context) => productViewModel,
                      child: Consumer<ProductViewModel>(
                        builder: (ctx, viewModel, _){
                          return ListTile(
                            leading: const Icon(Icons.check),
                            title: const Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onTap: (){
                              productViewModel.deleteProduct(product!.id);
                              if(viewModel.response.status == Status.COMPLETED){
                                Navigator.pop(context);
                                print('Delete complete');
                              }
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.close),
                      title: const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },

      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  UpdateProduct(isFromUpdate: true, product: product)),   // Navigate to homepage screen
        );
      },

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
    );
  }
}
