import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/app/models/post.dart';
import 'package:insta/app/models/user.dart';
import 'package:insta/app/repositories/auth_repository.dart';
import 'package:insta/app/repositories/post_repository.dart';
import 'package:insta/config/route/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final PostRepository postRepository = PostRepository();
  final AuthRepository authRepository = AuthRepository();
  Rx<File?> image = Rx<File?>(null); 
  Rx<int> index = Rx<int>(0);
  final TextEditingController captionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  RxList posts = <Post>[].obs;
  RxBool loadingPost = false.obs;
  Rx<User?> user = Rx(null);

  @override
  void onInit() {
    super.onInit();
    getAllPost();
    getCurrentUser();
  }

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  Future<dynamic> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString("user");

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        user.value = User.fromMap(userMap);
      }
    } catch (e) {
      rethrow;
    }
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

  Future<void> likePost(String postId, int index) async {
    try {
      Map data = {"postId": postId};
      await postRepository.likePost(data);
      Post post = posts[index];
      Post newPost = post.copyWith(
          like: !post.like,
          quantityLike:
              post.like ? post.quantityLike - 1 : post.quantityLike + 1);
      posts[index] = newPost;
      posts.refresh();
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
      rethrow;
    }
  }

  Future<dynamic> createPost() async {
    loadingPost.value = true;
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
    } finally {
      loadingPost.value = false;
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
