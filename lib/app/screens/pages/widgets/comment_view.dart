import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/comment_controller.dart';
import 'package:insta/app/models/comment.dart';

class CommentView extends StatelessWidget {
  final Comment comment;
  final bool isReply;
  final CommentsController controller = Get.put(CommentsController());
  final Comment? parrentComment;
  final int level;

  CommentView(
      {super.key,
      required this.comment,
      this.isReply = false,
      this.parrentComment,
      this.level = 1});

  @override
  Widget build(BuildContext context) {
    double paddingLeft = level == 2 ? 40 : 0;
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, bottom: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    parrentComment != null
                        ? RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: '@${parrentComment!.userName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: comment.content,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        : Text(comment.content,
                            style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTimeAgo(comment.createdAt),
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Phản hồi',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (comment.replies.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...comment.replies.map((reply) => CommentView(
                  comment: reply,
                  isReply: true,
                  parrentComment: comment,
                  level: level + 1,
                )),
          ],
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Bây giờ';
    }
  }
}
