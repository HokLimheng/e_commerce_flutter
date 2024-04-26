import 'package:e_commerce/views/business_owner/businessOwner.dart';
import 'package:e_commerce/views/home/productDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../home/models/product.dart';
import '../home/skeleton/product_ske.dart';
import '../home/viewmodels/product_vm.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage ({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _productViewModel = ProductViewModel();

  final border = OutlineInputBorder(
      borderSide: const BorderSide(
        style: BorderStyle.none,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.circular(30)
  );

  final boxDecoration = BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20)
  );

  static String baseUrl = "https://cms.istad.co";



  @override
  void initState(){
    _productViewModel.getAllProduct();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: const Text(
          'NemoStore',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5, right: 0, left: 0),
                child: TextField(
                  onChanged: (value){
                    print(value);
                    // _productViewModel.searchQuery = value;
                    _productViewModel.searchProducts(value);
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What are you looking for...',
                    hintStyle: const TextStyle(
                      fontFamily: 'ProductSans',
                    ),
                    prefixIcon: const Icon(Icons.search_rounded),
                    enabledBorder: border,
                    focusedBorder: border,
                    fillColor: Colors.grey.withOpacity(0.1),
                    filled: true,
                  ),
                ),
              ),
              // Products
              ChangeNotifierProvider(
                create: (context) => _productViewModel,
                child: Consumer<ProductViewModel>(
                  builder: (context, viewModel, _) {
                    switch (viewModel.response.status!) {
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
                        // int length = viewModel.response.data!.data!.length;
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            // itemCount: products?.length, // Use the actual length of the data
                            itemCount: viewModel.response.data!.data!.length == 0 ? 1 : viewModel.response.data!.data!.length,
                            itemBuilder: (context, index) {
                              final product =  viewModel.response.data!.data![index];
                              final String title = product.attributes?.title?.toString() ?? 'Title not available';
                              final String price = product.attributes?.price?.toString() ?? 'Price not available';
                              final String image = product.attributes?.thumbnail?.data?.attributes?.url != null
                                  ? '$baseUrl${product.attributes?.thumbnail?.data?.attributes?.url}'
                                  : 'https://th.bing.com/th/id/R.8abcc8217dd66a7ecdc581444b5cea11?rik=Q9QZz%2fIRtLecKA&pid=ImgRaw&r=0'; // Provide a default value for the image URL
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ProductPage(product: product,))   // Navigate to homepage screen
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 9,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(image),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '\$ $price',
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.grey[800],
                                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                                      ),
                                                      child: const Text(
                                                        'Add to Cart',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
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


