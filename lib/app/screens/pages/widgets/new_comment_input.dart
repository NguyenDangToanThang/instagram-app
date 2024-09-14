import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/comment_controller.dart';

class NewCommentInput extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
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
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(
                  color: Colors.white, backgroundColor: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Phản hồi',
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                controller.addComment(_textController.text);
                _textController.clear();
              }
            },
            child: const Text('Gửi', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
