import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/models/post.dart';
import 'package:intl/intl.dart';

class PostView extends StatelessWidget {
  final Post post;
  final int index;

  const PostView({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              post.avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(post.avatar!),
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
                    post.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(post.createdAt),
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(width: 8),
              const Spacer(),
              post.follow
                  ? const Text('')
                  : InkWell(
                      onTap: () {
                        homeController.followUser(post.email, index);
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
          if (post.caption.isNotEmpty)
            Text(post.caption, style: const TextStyle(color: Colors.white)),
          if (post.contentUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.network(
                post.contentUrl!,
                fit: BoxFit.contain,
                height: 300,
                width: double.infinity,
              ),
            ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              Text(post.quantityLike.toString()),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline),
              ),
              Text(post.quantityComment.toString()),
              const SizedBox(width: 10),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
