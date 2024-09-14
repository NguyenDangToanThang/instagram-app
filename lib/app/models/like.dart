// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Like {
  String id;
  String username;
  String email;
  String avatar;
  bool follow;
  Like({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.follow,
  });

  Like copyWith({
    String? id,
    String? username,
    String? email,
    String? avatar,
    bool? follow,
  }) {
    return Like(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      follow: follow ?? this.follow,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'follow': follow,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : "",
      follow: map['follow'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) =>
      Like.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Like(id: $id, username: $username, email: $email, avatar: $avatar, follow: $follow)';
  }

  @override
  bool operator ==(covariant Like other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.avatar == avatar &&
        other.follow == follow;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        follow.hashCode;
  }
}
