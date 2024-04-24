import 'package:e_commerce/views/business_owner/post_products.dart';
import 'package:e_commerce/views/business_owner/product_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../profile/viewmodels/image_viewmodel.dart';
import 'models/request/product_request.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({super.key});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {

  bool isPicked = false;
  var imageFile;
  final nameController = TextEditingController();
  final ratingController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final _imageViewModel = ImageViewModel();
  final _productViewModel = ProductViewModel();
  var imageId;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Post New Product ', style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: ChangeNotifierProvider(
                  create: (context) => _imageViewModel,
                  child: Consumer<ImageViewModel>(
                    builder: (ctx, viewModel, _){

                      if(viewModel.response.status == null){
                        return InkWell(
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 32.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onTap: (){
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
                                        'Choose Profile Photo',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text(
                                          'Take a Photo',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        onTap: () {
                                          _getImageFromSource(source: 'camera');
                                          Navigator.pop(context); // Close the bottom sheet
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_size_select_actual_outlined),
                                        title: const Text(
                                          'Choose from Gallery',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        onTap: () {
                                          _getImageFromSource(source: 'gallery');
                                          Navigator.pop(context); // Close the bottom sheet
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            // _getImageFromSource(source: 'camera');
                          },

                        );
                      }
                      switch(viewModel.response.status!){
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.COMPLETED:
                          imageId = viewModel.response.data[0].id;
                          return InkWell(
                            onTap: (){
                              _getImageFromSource(source: 'camera');
                            },
                            child: SizedBox(
                              width: 350,
                              height: 250,
                              child: Image.network('https://cms.istad.co${viewModel.response.data[0].url!}'),
                            ),
                          );
                        case Status.ERROR:
                          return Text(viewModel.response.message!);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Product Name',
                  border: OutlineInputBorder(
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ratingController,
                decoration: const InputDecoration(
                  hintText: 'Rating',
                  border: OutlineInputBorder(
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Discount
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Delivery Time
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  hintText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Category
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  border: OutlineInputBorder(
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ChangeNotifierProvider(
                create: (context) => _productViewModel,
                child: Consumer<ProductViewModel>(
                  builder: (ctx, viewModel, _){
                    if(viewModel.response.status == null){
                      print(viewModel.response.status);
                      return ElevatedButton(
                        onPressed: (){
                          _saveProduct();
                        },
                        child: const Text('Post'),);
                    }
                    switch(viewModel.response.status!){
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Post Success')),
                          );
                        });
                        return ElevatedButton(
                          onPressed: (){
                            _saveProduct();
                            print('post');
                          },
                          child: const Text('Post'),);
                      case Status.ERROR:
                        return Text(viewModel.response.message!);
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
  _getImageFromSource({source}) async {

    XFile? pickedFile = await ImagePicker().pickImage(
      source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
    );
    if(pickedFile != null){
      // uploading image to server
      _imageViewModel.uploadingImage(pickedFile.path);
      // setState(() {
      //   isPicked = true;
      //   imageFile = File(pickedFile.path);
      // });
    }
  }

  void _saveProduct() {
    print('loading');
    var productRequest = ProductRequest(
        data: DataRequest(
          title: nameController.text,
          rating: ratingController.text,
          description: descriptionController.text,
          quantity: quantityController.text,
          price: priceController.text,
          thumbnail: imageId.toString(),
        )
    );
    _productViewModel.postProduct1(productRequest);
  }
}
