import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/comment_controller.dart';
import 'package:insta/app/screens/pages/widgets/comment_view.dart';
import 'package:insta/app/screens/pages/widgets/new_comment_input.dart';

class CommentsScreen extends StatelessWidget {
  final CommentsController controller = Get.put(CommentsController());

  CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Bình luận',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    return CommentView(comment: controller.comments[index]);
                  },
                ),
              ),
            ),
            const Divider(height: 1),
            NewCommentInput(),
          ],
        ),
      ),
    );
  }
}
