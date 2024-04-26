import 'package:flutter/cupertino.dart';
import 'package:e_commerce/views/business_owner/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../home/models/product.dart';
import '../profile/viewmodels/image_viewmodel.dart';
import 'models/request/product_request.dart';


class UpdateProduct extends StatefulWidget {
  UpdateProduct({this.isFromUpdate, this.product});

  bool? isFromUpdate;
  Datum? product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}


class _UpdateProductState extends State<UpdateProduct> {

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
  var productId;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productInfo();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product ', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),),
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

                      if(widget.isFromUpdate!){

                        return InkWell(
                          child: SizedBox(
                            height:  MediaQuery.of(context).size.height * 0.55,
                            width: double.infinity,
                            child: Image.network(
                              'https://cms.istad.co${widget.product!.attributes!.thumbnail!.data!.attributes!.url}',
                              fit: BoxFit.contain,
                            ),
                          ),
                          onTap: () {
                            _getImageFromSource(source: 'camera');
                          },
                        );
                      }

                      if(viewModel.response.status == null){
                        return InkWell(
                          child: Image.network('https://images.freeimages.com/images/large-previews/cfd/picture-frame-1230741.jpg', fit: BoxFit.contain,),
                          onTap: (){
                            _getImageFromSource(source: 'camera');
                          },
                        );
                      }


                      switch(viewModel.response.status!){
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.COMPLETED:
                          // imageId = viewModel.response.data[0].id;
                          return InkWell(
                            onTap: (){
                              _getImageFromSource(source: 'camera');
                            },
                            child: SizedBox(
                              width: 350,
                              height: 250,
                              child: Image.network('https://cms.istad.co${viewModel.response.data[0].id}'),
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
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                          ),
                        onPressed: (){
                          _saveProduct();
                        },
                        child: const Text('Update', style: TextStyle(color: Colors.white),));
                    }
                    switch(viewModel.response.status!){
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Update Success')),
                          );
                        });
                        return ElevatedButton(
                          onPressed: (){
                            print('Test: ${viewModel.response.status}');
                            _saveProduct();
                          },
                          child: const Text('save'),);
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
    _productViewModel.postProduct(productRequest,
        isUpdate: widget.isFromUpdate,
        id: productId,
    );
  }

  void productInfo(){
      nameController.text = widget.product!.attributes!.title!;
      ratingController.text = widget.product!.attributes!.rating!;
      descriptionController.text = widget.product!.attributes!.description!;
      quantityController.text = widget.product!.attributes!.quantity!;
      priceController.text = widget.product!.attributes!.price!;
      imageId = widget.product!.attributes!.thumbnail!.data!.id;
      productId = widget.product!.id;
  }
}
