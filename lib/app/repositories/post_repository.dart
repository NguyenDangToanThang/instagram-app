import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insta/config/api_endpoints.dart';
import 'package:insta/config/data/network/base_api_service.dart';
import 'package:insta/config/data/network/network_api_service.dart';

class PostRepository {
  final BaseApiServices baseAPI = NetworkApiServices();
  final storage = const FlutterSecureStorage();

  Future<dynamic> getAllPost() async {
    try {
      dynamic response = await baseAPI.getGetApiResponse(ApiEndpoints.postUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createPost(File? image, String? caption) async {
    try {
      await baseAPI.getMultipartApiResponse(
          ApiEndpoints.createPostUrl, image, caption);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> followUser(Map data) async {
    try {
      dynamic response =
          await baseAPI.getPostApiResponse(ApiEndpoints.followUser, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
