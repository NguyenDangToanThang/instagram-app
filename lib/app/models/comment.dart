// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comment {
  final String id;
  final String username;
  final String email;
  final String avatar;
  final DateTime createdDate;
  final String content;
  final String parentCommentId;
  final String parentName;
  int countReply;
  List<Comment> replies;
  Comment({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.createdDate,
    required this.content,
    required this.parentCommentId,
    required this.parentName,
    required this.countReply,
    required this.replies,
  });

  Comment copyWith({
    String? id,
    String? username,
    String? email,
    String? avatar,
    DateTime? createdDate,
    String? content,
    String? parentCommentId,
    String? parentName,
    int? countReply,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdDate: createdDate ?? this.createdDate,
      content: content ?? this.content,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      parentName: parentName ?? this.parentName,
      countReply: countReply ?? this.countReply,
      replies: replies ?? this.replies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'createdDate': createdDate.toIso8601String(),
      'content': content,
      'parentCommentId': parentCommentId,
      'parentName': parentName,
      'countReply': countReply,
      'replies': replies.map((x) => x.toMap()).toList(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : '',
      createdDate: DateTime.parse(map['createdDate'] as String),
      content: map['content'] as String,
      parentCommentId: map['parentCommentId'] != null
          ? map['parentCommentId'] as String
          : "",
      parentName: map['parentName'] != null ? map['parentName'] as String : "",
      countReply: map['countReply'] != null ? map['countReply'] as int : 0,
      replies: map['replies'] != null
          ? List<Comment>.from(
              (map['replies'] as List<dynamic>).map<Comment>(
                (x) => Comment.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
