import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/views/business_owner/post_products.dart';
import 'package:e_commerce/views/business_owner/product_card_business_owner.dart';
import 'package:e_commerce/views/home/skeleton/product_ske.dart';
import 'package:e_commerce/views/home/viewmodels/product_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/models/product.dart';

class BusinessOwner extends StatefulWidget {
  const BusinessOwner({super.key});

  @override
  State<BusinessOwner> createState() => _BusinessOwnerState();
}

class _BusinessOwnerState extends State<BusinessOwner> {

  final _productViewModel = ProductViewModel();

  @override
  void initState(){
    super.initState();
    _productViewModel.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // app bar
      appBar: AppBar(
        title: Text('Business Owner', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PostProduct())   // Navigate to homepage screen
            );
           },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              // Products
              ChangeNotifierProvider(
                create: (context) => _productViewModel,
                child: Consumer<ProductViewModel>(
                  builder: (context, viewModel, _){
                    switch(viewModel.response.status!){
                      case Status.LOADING:
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 7, // Number of rows
                          itemBuilder: (context, rowIndex) {
                            return const Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ProductCardSkeleton(),
                                    ),
                                    Expanded(
                                      child: ProductCardSkeleton(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10), // Add spacing between rows
                              ],
                            );
                          },
                        );
                      case Status.COMPLETED:
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.response.data!.data!.length ~/ 2,
                          itemBuilder: (context, rowIndex) {
                            // Get the two products for the current row
                            int index1 = rowIndex * 2;
                            int index2 = index1 + 1;
                            Datum? product1 = index1 < viewModel.response.data!.data!.length
                                ? viewModel.response.data!.data![index1]
                                : null;
                            Datum? product2 = index2 < viewModel.response.data!.data!.length
                                ? viewModel.response.data!.data![index2]
                                : null;

                            return Row(
                              children: [
                                if (product1 != null)
                                  Expanded(
                                    child: ProductCardOwner(product: product1),
                                  ),
                                if (product2 != null)
                                  Expanded(
                                    child: ProductCardOwner(product: product2),
                                  ),
                              ],
                            );
                          },
                        );
                      case Status.ERROR:
                        return Center(child: Text("Error"));
                    }
                  },
                ),
              )

            ],
          ),

        ),
      ),
    );
  }


}
