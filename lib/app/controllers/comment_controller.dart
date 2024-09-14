import 'package:get/get.dart';
import '../models/comment.dart';

class CommentsController extends GetxController {
  final comments = <Comment>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  void fetchComments() {
    // Simulating API call
    Future.delayed(Duration(seconds: 1), () {
      comments.value = [
        Comment(
          id: '1',
          content: 'This is a great post!',
          userId: 'user1',
          userName: 'John Doe',
          createdAt: DateTime.now().subtract(Duration(hours: 2)),
          replies: [
            Comment(
              id: '2',
              content: 'Thanks, I agree!',
              userId: 'user2',
              userName: 'Jane Smith',
              createdAt: DateTime.now().subtract(Duration(hours: 1)),
              replies: [
                Comment(
                  id: '4',
                  content: 'Thanks, I agree!',
                  userId: 'user2',
                  userName: 'Jane Smith',
                  createdAt: DateTime.now().subtract(Duration(hours: 1)),
                ),
              ],
            ),
          ],
        ),
        Comment(
          id: '3',
          content: 'Nice photo!',
          userId: 'user3',
          userName: 'Bob Johnson',
          createdAt: DateTime.now().subtract(Duration(minutes: 30)),
        ),
      ];
    });
  }

  void addComment(String content) {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      userId: 'currentUser',
      userName: 'Current User',
      createdAt: DateTime.now(),
    );
    comments.add(newComment);
  }
}
