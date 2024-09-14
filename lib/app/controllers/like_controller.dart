import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/models/like.dart';
import 'package:insta/app/repositories/like_repository.dart';

class LikeController extends GetxController {
  final LikeRepository likeRepository = LikeRepository();
  final TextEditingController searchLikerController = TextEditingController();

  RxList<Like> likes = <Like>[].obs;

  @override
  void onInit() {
    super.onInit();
    final String postId = Get.arguments['postId'];
    print(postId);
    getListLike(postId);
  }

  @override
  void onClose() {
    super.onClose();
    likes.clear();
  }

  Future<dynamic> getListLike(String postId) async {
    try {
      Map data = {"postId": postId};
      final jsonData = await likeRepository.getAllLikes(data);
      print(jsonData);
      likes.value = parseLikes(jsonData['data']);
    } catch (e) {
      rethrow;
    }
  }

  List<Like> parseLikes(dynamic jsonData) {
    final List<dynamic> likes = jsonData as List<dynamic>;
    return likes
        .map((json) => Like.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
