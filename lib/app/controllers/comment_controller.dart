import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/app/controllers/home_controller.dart';
import 'package:insta/app/models/post.dart';
import 'package:insta/app/repositories/comment_repository.dart';
import '../models/comment.dart';

class CommentsController extends GetxController {
  final commentRepository = CommentRepository();
  final TextEditingController textController = TextEditingController();
  RxList comments = <Comment>[].obs;
  Rx<Comment> commentParent = Rx(Comment(
      id: "",
      username: "",
      email: "",
      avatar: "",
      createdDate: DateTime.now(),
      content: "",
      parentCommentId: "",
      parentName: "",
      countReply: 0,
      replies: []));
  final homeController = Get.find<HomeController>();
  final String postId = Get.arguments['postId'];

  @override
  void onInit() {
    super.onInit();
    getTopComments();
  }

  void resetParentComment() {
    commentParent.value = Comment(
        id: "",
        username: "",
        email: "",
        avatar: "",
        createdDate: DateTime.now(),
        content: "",
        parentCommentId: "",
        parentName: "",
        countReply: 0,
        replies: []);
    commentParent.refresh();
  }

  Future<dynamic> replyComment(String commentId, String content) async {
    try {
      Map data = {"postId": postId, "content": content};
      final dataJson = await commentRepository.replyComment(data, commentId);
      Comment dataComment = Comment.fromMap(dataJson['data']);
      List<Comment> rootComments = comments.toList() as List<Comment>;
      bool found = false;

      for (int i = 0; i < rootComments.length; i++) {
        if (rootComments[i].id == commentId) {
          rootComments[i].replies.add(dataComment);
          rootComments[i].countReply++;
          rootComments[i] = rootComments[i].copyWith();
          found = true;
          break;
        } else {
          for (int j = 0; j < rootComments[i].replies.length; j++) {
            if (rootComments[i].replies[j].id == commentId) {
              rootComments[i].replies.add(dataComment);
              rootComments[i].countReply++;
              rootComments[i] = rootComments[i].copyWith(); // Trigger update for UI
              found = true;
              break;
            }
          }
        }
        if (found) break;
      }
      updatePost();
      comments.refresh();
      resetParentComment();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> getTopComments() async {
    try {
      Map data = {"postId": postId};
      final dataJson = await commentRepository.getTopComments(data);
      List<Comment> list = parseComments(dataJson['data']);
      comments.value = list;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> getReplyComments(String commentId) async {
    try {
      final dataJson = await commentRepository.getReplyComments(commentId);
      List<Comment> list = parseComments(dataJson['data']);
      List<Comment> rootComments = comments.toList() as List<Comment>;
      for (int i = 0; i < rootComments.length; i++) {
        if (rootComments[i].id == commentId) {
          rootComments[i].replies.addAll(list);
        }
      }
      comments.value = rootComments;
      comments.refresh();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> commentPost(String content) async {
    try {
      Map data = {"postId": postId, "content": content};
      final dataJson = await commentRepository.commentPost(data);
      Comment comment =
          Comment.fromMap(dataJson['data'] as Map<String, dynamic>);
      comments.add(comment);
      updatePost();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  List<Comment> parseComments(dynamic dataJson) {
    final List<dynamic> comments = dataJson as List<dynamic>;
    return comments
        .map((json) => Comment.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  void updatePost() {
    List<Post> posts = homeController.posts.toList() as List<Post>;

    int postIndex = posts.indexWhere((post) => post.id == postId);

    if (postIndex != -1) {
      Post updatedPost = posts[postIndex].copyWith(
        quantityComment: posts[postIndex].quantityComment + 1,
      );

      posts[postIndex] = updatedPost;

      homeController.posts.value = List<Post>.from(posts);
      homeController.posts.refresh();
    } else {
      print("Không tìm thấy bài đăng với id: $postId");
    }
  }
}
