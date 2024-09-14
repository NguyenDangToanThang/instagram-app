class Comment {
  final String id;
  final String content;
  final String userId;
  final String userName;
  final DateTime createdAt;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    required this.createdAt,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      userId: json['userId'],
      userName: json['userName'],
      createdAt: DateTime.parse(json['createdAt']),
      replies: (json['replies'] as List?)
          ?.map((reply) => Comment.fromJson(reply))
          .toList() ?? [],
    );
  }
}