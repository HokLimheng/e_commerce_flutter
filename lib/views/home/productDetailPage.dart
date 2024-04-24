import 'package:e_commerce/views/home/models/cart.dart';
import 'package:e_commerce/views/home/viewmodels/product_vm.dart';
import 'package:e_commerce/views/home/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.product});

  Datum? product;


  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  static String baseUrl = "https://cms.istad.co";

  final List<String> sizes = ['S', 'M', 'L'];
  final List<Color> colors = [Colors.teal, Colors.black, Colors.pink, Colors.grey];
  String? selectedSize;
  Color? selectedColor;

  //quantity
  int quantityCount = 0;

  // decrement quantity
  void decrementQuantity(){
    setState(() {
      if(quantityCount > 0){
       quantityCount--;
      }
    });
  }

  // increase quantity
  void incrementQuantity(){
    setState(() {
      quantityCount++;
    });
  }

  // add to cart
  void addToCard(){

    if(quantityCount > 0){

      final cart = context.read<Product>();

      cart.addToCart(widget.product!, quantityCount);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Item added successfully.', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                // Pop the dialog and go back to the previous screen
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0),
                height:  MediaQuery.of(context).size.height * 0.40,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('$baseUrl${widget!.product!.attributes!.thumbnail!.data!.attributes!.url!}',),

                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.45,
                    // width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(23), topLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(245, 247, 249, 1), spreadRadius: 0, blurRadius: 1),
                      ],
                    ),
                    child:  Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow[800]),
                              const SizedBox(width: 5),
                              Text(widget.product!.attributes!.rating.toString(), style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.product!.attributes!.title.toString(), style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ProductSans',
                              ),
                              ),
                              Text('\$ ${widget.product!.attributes!.price.toString()}', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'ProductSans',
                              ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('Sizes', style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'ProductSans',
                          ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              itemCount: sizes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                final size = sizes[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 15),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        selectedSize = size;
                                      });
                                    },
                                    child: SizeOption(label: sizes[index], isSelected: selectedSize == size),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Colors', style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'ProductSans',
                          ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              itemCount: colors.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final color = colors[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = color;
                                      });
                                    },
                                    child: ColorOption(color: color, isSelected: selectedColor == color),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Description
                          Text('Description', style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          ),
                          Text(widget.product!.attributes!.description.toString(), maxLines: 7 , overflow: TextOverflow.ellipsis, style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            height: 2
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // price, quantity, add cart
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(57, 120, 114, 0.8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // price + quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // price
                        Text("\$ ${widget.product!.attributes!.price!.toString()}", style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        ),
                        Row(
                          children: [
                            //decrease button
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 152, 146, 1),
                                  shape: BoxShape.circle
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove,
                                  color: Colors.white,
                                ),
                                onPressed: decrementQuantity,
                              ),
                            ),

                            // quantity count
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(quantityCount.toString(), style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),

                            // increase button
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 152, 146, 1),
                                  shape: BoxShape.circle
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: incrementQuantity,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 25,),
                    // add to cart button
                    ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(79, 152, 146, 1),
                        minimumSize: const Size(203, 48),
                      ),
                      onPressed: (){
                        addToCard();
                      },
                      child: const Text('Add to cart', style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'ProductSans',
                      ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Positioned(
            top: 25.0,
            left: 10.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 0.8,
              backgroundColor: Colors.white,
              child: const Icon(Icons.arrow_back),
            ),
          ),

        ],
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const SizeOption({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.redAccent : Colors.black,
            // fontSize: 1,
          ),
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorOption({super.key, required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 2,
        ),
        boxShadow: isSelected ? [
          BoxShadow(
            color: color.withOpacity(1),
            blurStyle: BlurStyle.outer,
            blurRadius: 2,
            spreadRadius: 4,
          ),
        ] : null,
      ),
    );
  }
}