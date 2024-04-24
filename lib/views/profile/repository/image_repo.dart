import '../../../data/network/api_service.dart';
import '../../../res/app_url.dart';
import '../models/response/image_response.dart';

class ImageRepository {
  final _apiService = ApiService();

  Future<List<ImageResponse>> uploadImage(image) async{
    var response = await _apiService.uploadImage(image, AppUrl.uploadImage);
    return imageResponseFromJson(response);
  }
}