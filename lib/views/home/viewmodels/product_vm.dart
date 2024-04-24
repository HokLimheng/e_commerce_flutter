import 'package:e_commerce/views/home/respositary/product_repo.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/response/api_response.dart';


class ProductViewModel extends ChangeNotifier{

  final _productRepo = ProductRepository();
  ApiResponse<dynamic> response = ApiResponse.loading();
  var deleteResponse = ApiResponse();



  setProductList(response){
    this.response = response;
    notifyListeners();
  }

  setDeleteResponse(response){
    deleteResponse = response;
    notifyListeners();
  }

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners(); // Notify listeners about the change
  }


  Future<dynamic> getAllProduct() async{
    await _productRepo.getAllProducts()
        .then((product) => setProductList(ApiResponse.completed(product)))
        .onError((error, stackTrace) => setProductList(ApiResponse.error(stackTrace.toString())));
  }

  Future<dynamic> deleteProduct(id) async {
    await _productRepo.deleteProduct(id)
        .then((data) => setDeleteResponse(ApiResponse.completed(data)))
        .onError((error, stackTrace) => setDeleteResponse(ApiResponse.error(stackTrace.toString())));
  }

  Future<dynamic> searchProducts(String query) async {
    await _productRepo.searchProduct(query)
        .then((data) => setProductList(ApiResponse.completed(data)))
        .onError((error, stackTrace) => setProductList(ApiResponse.error(stackTrace.toString())));
  }

}