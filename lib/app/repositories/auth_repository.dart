import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta/config/api_endpoints.dart';
import 'package:insta/config/data/network/base_api_service.dart';
import 'package:insta/config/data/network/network_api_service.dart';
import 'package:insta/config/instants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepository {
  final BaseApiServices baseAPI = NetworkApiServices();
  final storage = const FlutterSecureStorage();

  Future<dynamic> registerAPI(Map data) async {
    try {
      dynamic response = await baseAPI.getPostApiResponse(
          "${ApiEndpoints.authUrl}/signup", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginAPI(Map data) async {
    try {
      dynamic response = await baseAPI.getPostApiResponse(
          "${ApiEndpoints.authUrl}/signin", data);
      if (response['data']['token'] != null) {
        String token = response['data']['token'];
        String refreshToken = response['data']['refreshToken'];
        await storage.write(key: "accessToken", value: token);
        await storage.write(key: "refreshToken", value: refreshToken);
        await storage.write(key: "email", value: data['email']);
        ApiEndpoints.headers
            .putIfAbsent('Authorization', () => 'Bearer $token');
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> logoutAPI() async {
    try {
      await baseAPI.getDeleteApiResponse(ApiEndpoints.logout, null);
      ApiEndpoints.headers.remove("Authorization");
      await storage.delete(key: "accessToken");
      await storage.delete(key: "refreshToken");
      await storage.delete(key: "email");
    } catch (e) {
      rethrow;
    }
  }

  Future<String> checkToken() async {
    String? token = await storage.read(key: "accessToken");
    if (token != null) {
      bool isExpired = JwtDecoder.isExpired(token);
      if (isExpired) {
        await storage.delete(key: "accessToken");
        ApiEndpoints.headers.remove("Authorization");
        String? refreshToken = await storage.read(key: "refreshToken");
        if (JwtDecoder.isExpired(refreshToken!)) {
          await storage.delete(key: "refreshToken");
          return Instants.refreshTokenExpired;
        } else {
          try {
            dynamic response = await baseAPI.getPostApiResponse(
                "${ApiEndpoints.authUrl}/refresh", refreshToken);
            String? newToken = response['data']['token'];
            await storage.write(key: "accessToken", value: newToken);
            ApiEndpoints.headers
                .putIfAbsent("Authorization", () => "Bearer $newToken");
            return Instants.tokenValid;
          } catch (e) {
            return Instants.errorRefreshToken;
          }
        }
      }
      ApiEndpoints.headers.putIfAbsent("Authorization", () => "Bearer $token");
      return Instants.tokenValid;
    }
    return Instants.tokenNotFound;
  }
}
