import 'package:insta/config/api_endpoints.dart';
import 'package:insta/config/data/network/base_api_service.dart';
import 'package:insta/config/data/network/network_api_service.dart';

class CommentRepository {
  final BaseApiServices baseAPI = NetworkApiServices();

  Future<dynamic> getTopComments(Map data) async {
    try {
      dynamic response = await baseAPI.getPostApiResponse(
          ApiEndpoints.getListsCommentPostUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> replyComment(Map data, String commentId) async {
    try {
      dynamic response = await baseAPI.getPostApiResponse(
          "${ApiEndpoints.replyComment}/$commentId", data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getReplyComments(String commentId) async {
    try {
      dynamic response = await baseAPI
          .getGetApiResponse("${ApiEndpoints.getCommentReplies}/$commentId");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> commentPost(Map data) async {
    try {
      dynamic response =
          await baseAPI.getPostApiResponse(ApiEndpoints.commentPostUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
