import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/like_controller.dart';
import 'package:insta/app/models/like.dart';

class LikeView extends StatefulWidget {
  const LikeView({super.key, required this.like, required this.index});

  final Like like;
  final int index;

  @override
  State<LikeView> createState() => _LikeViewState();
}

class _LikeViewState extends State<LikeView> {
  final likeController = Get.find<LikeController>();
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          widget.like.email,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue , borderRadius: BorderRadius.circular(5)),
            child: Obx(() {
              return likeController.likes[widget.index].follow
                  ? const Text("Đang theo dõi",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
                  : const Text("Theo dõi",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14));
            })),
        subtitle: Text(
          widget.like.username,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: widget.like.avatar == ""
            ? const CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.jpg"))
            : CircleAvatar(backgroundImage: NetworkImage(widget.like.avatar)));
  }
}
