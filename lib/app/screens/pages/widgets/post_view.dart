import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/models/post.dart';
import 'package:insta/config/route/routes.dart';
import 'package:intl/intl.dart';

class PostView extends StatefulWidget {
  final Post post;
  final int index;

  const PostView({super.key, required this.post, required this.index});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey[800], // Thêm màu nền để làm nổi bật viền bo tròn
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.post.avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.post.avatar!),
                      backgroundColor: Colors.grey,
                      radius: 20,
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                      backgroundColor: Colors.grey,
                      radius: 20),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                      DateFormat('dd MMM yyyy, hh:mm a')
                          .format(widget.post.createdAt),
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(width: 8),
              const Spacer(),
              widget.post.follow
                  ? const Text('')
                  : InkWell(
                      onTap: () {
                        homeController.followUser(
                            widget.post.email, widget.index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(2)),
                        child: const Text("Theo dõi"),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 5),
          if (widget.post.caption.isNotEmpty)
            Text(widget.post.caption,
                style: const TextStyle(color: Colors.white)),
          if (widget.post.contentUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.network(
                widget.post.contentUrl!,
                fit: BoxFit.contain,
                height: 300,
                width: double.infinity,
              ),
            ),
          Row(
            children: [
              Obx(() => IconButton(
                    onPressed: () =>
                        homeController.likePost(widget.post.id, widget.index),
                    icon: homeController.posts[widget.index].like
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                  )),
              Obx(() => InkWell(
                    onTap: () => Get.toNamed(
                      Routes.likeScreen,
                      arguments: {'postId': widget.post.id},
                    ),
                    child: Text(
                        style: const TextStyle(color: Colors.white),
                        homeController.posts[widget.index].quantityLike
                            .toString()),
                  )),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.black,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.commentScreen),
                child: Text(
                    style: const TextStyle(color: Colors.white),
                    widget.post.quantityComment.toString()),
              ),
              const SizedBox(width: 10),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
