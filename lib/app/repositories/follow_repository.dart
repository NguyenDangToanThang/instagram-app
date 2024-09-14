import 'package:insta/config/api_endpoints.dart';
import 'package:insta/config/data/network/base_api_service.dart';
import 'package:insta/config/data/network/network_api_service.dart';

class FollowRepository {
  final BaseApiServices baseAPI = NetworkApiServices();

  Future<dynamic> getListFollower() async {
    try {
      dynamic response =
          await baseAPI.getGetApiResponse(ApiEndpoints.followUser);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
