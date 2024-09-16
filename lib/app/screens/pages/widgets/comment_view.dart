import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/comment_controller.dart';
import 'package:insta/app/models/comment.dart';

class CommentView extends StatelessWidget {
  final Comment comment;
  final bool isReply;
  final CommentsController controller = Get.put(CommentsController());

  CommentView({super.key, required this.comment, this.isReply = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 40 : 0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              comment.avatar != ""
                  ? const CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    )
                  : const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.username,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    comment.parentCommentId != ""
                        ? RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: '@${comment.parentName}',
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
                          _getTimeAgo(comment.createdDate),
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            controller.commentParent.value = comment;
                          },
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
                    const SizedBox(height: 4),
                    comment.countReply > 0 && comment.replies.isEmpty
                        ? InkWell(
                            onTap: () {
                              controller.getReplyComments(comment.id);
                            },
                            child: Text(
                              "Xem thêm ${comment.countReply} bình luận",
                              style: const TextStyle(color: Colors.white60),
                            ),
                          )
                        : const SizedBox.shrink()
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
