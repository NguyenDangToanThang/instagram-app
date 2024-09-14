import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/like_controller.dart';
import 'package:insta/app/models/like.dart';
import 'package:insta/app/screens/pages/widgets/like_view.dart';

class LikeScreen extends StatelessWidget {
  final LikeController likeController = Get.put(LikeController());
  LikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Lượt thích",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: likeController.searchLikerController,
              decoration: InputDecoration(
                  label: const Text(
                    "Tìm kiếm",
                    style: TextStyle(color: Colors.white),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (likeController.likes.isEmpty) {
                return const Center(
                  child: Text(
                    "Bài viết này chưa có lượt thích",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: likeController.likes.length,
                      itemBuilder: (context, index) {
                        final Like like = likeController.likes[index];
                        return LikeView(like: like, index: index);
                      }),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
