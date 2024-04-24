import 'package:e_commerce/views/business_owner/models/request/product_request.dart';
import 'package:e_commerce/views/home/models/product.dart';

import '../../../data/network/api_service.dart';
import '../../../res/app_url.dart';

class ProductRepository {
  static const String baseUrl = 'https://cms.istad.co/api';
  var apiService = ApiService();


  Future<Product> getAllProducts() async{
    try{
      dynamic response = await apiService.getApi(AppUrl.getAllProduct);
      print('test: ${productFromJson(response)}');
      return productFromJson(response);
    } catch(exception){
      rethrow;
    }
  }

  Future<dynamic> postProduct(data, {isUpdate, id}) async {
    var productRequest = productRequestToJson(data);
    var url = isUpdate ? '${AppUrl.postProduct}/$id' : AppUrl.postProduct;
    print('id $url');
    dynamic response = await apiService.postProduct(url, productRequest, isUpdate);

    return response;
  }

  Future<dynamic> postProduct1(data) async {
    var productRequest = productRequestToJson(data);
    var url = AppUrl.postProduct;
    print(productRequest);
    dynamic response = await apiService.postProduct1(url, productRequest);

    return response;
  }

  Future<dynamic> searchProduct(String searchQuery) async{
    print('hello');
    final url =
        '$baseUrl/e-commerce-products?filters[title][\$contains]=$searchQuery&populate=*';
    dynamic response = await apiService.getApi(url);
    print('test: ${productFromJson(response)}');
    return productFromJson(response);
  }


  Future<dynamic> deleteProduct(id) async {
    dynamic response = await apiService.deleteProduct('${AppUrl.postProduct}/$id');
    return response;
  }

}