import 'package:e_commerce/views/home/respositary/product_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../data/response/api_response.dart';

class ProductViewModel extends ChangeNotifier {
  final _productRepo = ProductRepository();
  var response = ApiResponse();

  setProductData(response){
    this.response = response;
    notifyListeners();
  }

  Future<dynamic> postProduct(data, {isUpdate, id})  async{
    setProductData(ApiResponse.loading());
    print('id $id');
    await _productRepo.postProduct(data, isUpdate : isUpdate, id: id)
        .then((isPosted) => setProductData(ApiResponse.completed(isPosted)))
        .onError((error, stackTrace) => setProductData(ApiResponse.error(stackTrace.toString())));
  }

  Future<dynamic> postProduct1 (data)  async{
    setProductData(ApiResponse.loading());
    await _productRepo.postProduct1(data)
        .then((isPosted) => setProductData(ApiResponse.completed(isPosted)))
        .onError((error, stackTrace) => setProductData(ApiResponse.error(stackTrace.toString())));
  }

}