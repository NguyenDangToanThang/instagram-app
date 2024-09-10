import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/screens/pages/widgets/post_view.dart';

class PostViewList extends StatefulWidget {
  const PostViewList({super.key});

  @override
  State<PostViewList> createState() => _PostViewListState();
}

class _PostViewListState extends State<PostViewList> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.posts.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: homeController.posts.length,
        itemBuilder: (context, index) {
          final post = homeController.posts[index];
          return PostView(post: post, index: index);
        },
      );
    });
  }
}
