
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta/config/api_endpoints.dart';
import 'package:insta/config/data/network/base_api_service.dart';
import 'package:insta/config/data/network/network_api_service.dart';

class LikeRepository {
  final BaseApiServices baseAPI = NetworkApiServices();
  final storage = const FlutterSecureStorage();

  Future<dynamic> getAllLikes(Map data) async {
    try {
      dynamic response = await baseAPI.getPostApiResponse(ApiEndpoints.getListsLikePostUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}