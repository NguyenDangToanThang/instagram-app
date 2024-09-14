import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/models/follow.dart';
import 'package:insta/app/repositories/follow_repository.dart';

class FollowController extends GetxController {
  final followRepository = FollowRepository();
  TextEditingController searchEdittingController = TextEditingController();
  RxList followers = <Follow>[].obs;

  @override
  void onInit() {
    super.onInit();
    getListFollowers();
  }

  Future<dynamic> getListFollowers() async {
    try {
      final jsonData = await followRepository.getListFollower();
      List<Follow> follows = parseFollowers(jsonData['data']);
      followers.value = follows;
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }

  List<Follow> parseFollowers(dynamic jsonData) {
    final List<dynamic> followers = jsonData as List<dynamic>;
    return followers
        .map((json) => Follow.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
