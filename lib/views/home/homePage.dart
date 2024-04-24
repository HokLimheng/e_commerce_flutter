import 'package:e_commerce/data/response/status.dart';
import 'package:e_commerce/views/home/searchPage.dart';
import 'package:e_commerce/views/home/skeleton/product_ske.dart';
import 'package:e_commerce/views/home/viewmodels/product_vm.dart';
import 'package:e_commerce/views/home/widgets/drawer.dart';
import 'package:e_commerce/views/home/widgets/productCard.dart';
import 'package:e_commerce/views/notification/notificationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _productViewModel = ProductViewModel();

  final List<String> filters = ['All', 'Clothes', 'Sport', 'Adidas'];

  late String selectedFilter = filters[3];

  @override
  void initState(){
    super.initState();
    _productViewModel.getAllProduct();
    selectedFilter = filters[0];
  }

  final border = OutlineInputBorder(
      borderSide: const BorderSide(
        style: BorderStyle.none,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.circular(30)
  );

  final boxDecoration = BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      // color: Color.fromRGBO(194, 194, 194, 0.1),
      borderRadius: BorderRadius.circular(20)
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // App Bar
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(120, 184, 192, 1),
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

        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationPage())   // Navigate to homepage screen
            );
           }, icon: const Icon(Icons.search))
        ],
      ),

      // Drawer
      drawer: const MyDrawer(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 25, right: 0, left: 0),
                child: TextField(
                  onChanged: (value){
                    // _productViewModel.search(value);
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

              // Discount container
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5, right: 0, left: 20),
                width: double.infinity,
                decoration: boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded( // Wrap the Row with Expanded
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shop with us now',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Get 40% offer for \n all items',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/shopwithus.png',
                        fit: BoxFit.contain,
                        width: 158,
                        height: 180,
                      ),
                    ),
                  ],
                ),
              ),

              // Filter products All, Clothes, Sport, Adidas
              SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: filters.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 15),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedFilter = filter;
                            print(selectedFilter);
                          });
                        },
                        child: Chip(
                          labelStyle: const TextStyle(fontSize: 16),
                          backgroundColor: selectedFilter == filter ? const Color.fromRGBO(120, 184, 192, 1) : const Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          label: Text(filter),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

             // Products
              SizedBox(
                height: 11 * (355),
                  child: ChangeNotifierProvider(
                    create: (context) => _productViewModel,
                    child: Consumer<ProductViewModel>(
                      builder: (context, viewModel, _){
                        switch(viewModel.response.status!){
                          case Status.LOADING:
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
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
                                        child: ProductCard(product: product1),
                                      ),
                                    if (product2 != null)
                                      Expanded(
                                        child: ProductCard(product: product2),
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
              )

            ],
          ),

        ),
      ),
    );
  }
}

