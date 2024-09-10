import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:insta/config/api_endpoints.dart';
import 'package:insta/config/data/app_exceptions.dart';
import 'package:insta/config/data/network/base_api_service.dart';
import 'package:path/path.dart';

class NetworkApiServices extends BaseApiServices {
  final storage = const FlutterSecureStorage();

  @override
  Future getDeleteApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await delete(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: ApiEndpoints.headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await get(Uri.parse(url), headers: ApiEndpoints.headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getMultipartApiResponse(
      String url, File? image, String? caption) async {
    try {
      var request = MultipartRequest('POST', Uri.parse(url));

      if(image != null) {
        // Thêm file ảnh vào request
      var imageStream = ByteStream(image.openRead());
      var imageLength = await image.length();
      var multipartFile = MultipartFile(
        'image', // Tên trùng với @RequestPart("image") trong server
        imageStream,
        imageLength,
        filename: basename(image.path), // Lấy tên file từ đường dẫn
      );

      request.files.add(multipartFile);
      }
      if (caption != null) {
        request.fields['caption'] = caption;
      }
      request.headers.addAll(ApiEndpoints.headers);
      await request.send();
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: ApiEndpoints.headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: ApiEndpoints.headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (response.body.isNotEmpty) {
          dynamic responseJson = jsonDecode(utf8.decode(response.bodyBytes));
          return responseJson;
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            "Lỗi khi liên lạc với máy chủ bằng mã trạng thái: ${response.statusCode}");
    }
  }
}
