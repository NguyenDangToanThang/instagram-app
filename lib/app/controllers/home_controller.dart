import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/app/models/post.dart';
import 'package:insta/app/repositories/auth_repository.dart';
import 'package:insta/app/repositories/post_repository.dart';
import 'package:insta/config/route/routes.dart';

class HomeController extends GetxController {
  final PostRepository postRepository = PostRepository();
  final AuthRepository authRepository = AuthRepository();
  Rx<File?> image = Rx<File?>(null); // Quản lý ảnh với Rx
  Rx<int> index = Rx<int>(0);
  final TextEditingController captionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  RxList posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllPost();
  }

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  Future<void> takePicture() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      Get.snackbar("Thông báo", "No image selected.");
    }
  }

  Future<List<Post>> getAllPost() async {
    try {
      final jsonData = await postRepository.getAllPost();
      List<Post> data = parsePosts(jsonData['data']['content']);
      posts.value = data;
      return data;
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
      rethrow;
    }
  }

  Future<dynamic> createPost() async {
    if (captionController.text.isEmpty) {
      Get.snackbar("Thông báo", "Vui lòng nhập chú thích");
      return;
    }
    try {
      await postRepository.createPost(image.value, captionController.text);
      image.value = null;
      captionController.clear();
      index.value = 0;
      refreshPosts();
      Get.snackbar("Thông báo", "Đăng bài viết thành công");
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
      rethrow;
    }
  }

  Future<void> refreshPosts() async {
    await getAllPost();
  }

  Future<void> followUser(String email, int postIndex) async {
    Map data = {"email": email};
    try {
      await postRepository.followUser(data);

      List<Post> newPost = posts.map<Post>((post) {
        if (post.email == email) {
          return post.copyWith(follow: true);
        }
        return post;
      }).toList();

      posts.value = newPost;
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
      rethrow;
    }
  }

  List<Post> parsePosts(dynamic jsonData) {
    final List<dynamic> posts = jsonData as List<dynamic>;
    return posts
        .map((json) => Post.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> logout() async {
    try {
      await authRepository.logoutAPI();
      Get.offAndToNamed(Routes.loginScreen);
    } catch (e) {
      rethrow;
    }
  }
}
