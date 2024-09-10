// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  final String id;
  final String email;
  final String username;
  final String? avatar;
  final DateTime createdAt;
  final String caption;
  final String? contentUrl;
  final int quantityLike;
  final int quantityComment;
  final bool like;
  final bool follow;
  Post({
    required this.id,
    required this.email,
    required this.username,
    required this.avatar,
    required this.createdAt,
    required this.caption,
    this.contentUrl,
    required this.quantityLike,
    required this.quantityComment,
    required this.like,
    required this.follow
  });

  Post copyWith({
    String? id,
    String? email,
    String? username,
    String? avatar,
    DateTime? createdAt,
    String? caption,
    String? contentUrl,
    int? quantityLike,
    int? quantityComment,
    bool? like,
    bool? follow
  }) {
    return Post(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      caption: caption ?? this.caption,
      contentUrl: contentUrl ?? this.contentUrl,
      quantityLike: quantityLike ?? this.quantityLike,
      quantityComment: quantityComment ?? this.quantityComment,
      like: like ?? this.like,
      follow: follow ?? this.follow
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'avatar': avatar,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'caption': caption,
      'contentUrl': contentUrl,
      'quantityLike': quantityLike,
      'quantityComment': quantityComment,
      'like': like,
      'follow': follow
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      caption: map['caption'] as String,
      contentUrl:
          map['contentUrl'] != null ? map['contentUrl'] as String : null,
      quantityLike: map['quantityLike'] as int,
      quantityComment: map['quantityComment'] as int,
      like: map['like'] as bool,
      follow: map['follow'] as bool
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, email: $email, username: $username, avatar: $avatar, createdAt: $createdAt, caption: $caption, contentUrl: $contentUrl, quantityLike: $quantityLike, quantityComment: $quantityComment, like: $like)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.username == username &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        other.caption == caption &&
        other.contentUrl == contentUrl &&
        other.quantityLike == quantityLike &&
        other.quantityComment == quantityComment &&
        other.like == like;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        username.hashCode ^
        avatar.hashCode ^
        createdAt.hashCode ^
        caption.hashCode ^
        contentUrl.hashCode ^
        quantityLike.hashCode ^
        quantityComment.hashCode ^
        like.hashCode;
  }
}
