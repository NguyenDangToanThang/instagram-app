import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/comment_controller.dart';

class NewCommentInput extends StatelessWidget {
  final CommentsController controller = Get.find();

  NewCommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Obx(() {
                  if (controller.commentParent.value.id != "") {
                    return Row(children: [
                      Text(
                        "Đang phản hồi ${controller.commentParent.value.username}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => controller.resetParentComment(),
                        child: const Icon(
                          Icons.remove_circle_outline_rounded,
                          color: Colors.white,
                        ),
                      )
                    ]);
                  }
                  return const SizedBox.shrink();
                }),
                TextField(
                  controller: controller.textController,
                  style: const TextStyle(
                      color: Colors.white, backgroundColor: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Phản hồi',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.textController.text.isNotEmpty &&
                  controller.commentParent.value.id == "") {
                controller.commentPost(controller.textController.text);
                controller.textController.clear();
              }
              if (controller.textController.text.isNotEmpty &&
                  controller.commentParent.value.id != "") {
                controller.replyComment(controller.commentParent.value.id,
                    controller.textController.text);
                controller.textController.clear();
              }
            },
            child: const Text('Gửi', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
