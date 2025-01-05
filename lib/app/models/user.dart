// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String id;
  String email;
  String fullname;
  String? avatar;
  String? bio;
  DateTime createdAt;
  int follower;
  User({
    required this.id,
    required this.email,
    required this.fullname,
    this.avatar,
    this.bio,
    required this.createdAt,
    required this.follower,
  });
  

  User copyWith({
    String? id,
    String? email,
    String? fullname,
    String? avatar,
    String? bio,
    DateTime? createdAt,
    int? follower,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      follower: follower ?? this.follower,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullname': fullname,
      'avatar': avatar,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'follower': follower,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
      follower: map['follower'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, email: $email, fullname: $fullname, avatar: $avatar, bio: $bio, createdAt: $createdAt, follower: $follower)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.fullname == fullname &&
      other.avatar == avatar &&
      other.bio == bio &&
      other.createdAt == createdAt &&
      other.follower == follower;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      fullname.hashCode ^
      avatar.hashCode ^
      bio.hashCode ^
      createdAt.hashCode ^
      follower.hashCode;
  }
}
