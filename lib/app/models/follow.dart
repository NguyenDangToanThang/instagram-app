// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Follow {
  String email;
  String fullname;
  String avatar;
  Follow({
    required this.email,
    required this.fullname,
    required this.avatar,
  });

  Follow copyWith({
    String? email,
    String? fullname,
    String? avatar,
  }) {
    return Follow(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullname': fullname,
      'avatar': avatar,
    };
  }

  factory Follow.fromMap(Map<String, dynamic> map) {
    return Follow(
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Follow.fromJson(String source) => Follow.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Follow(email: $email, fullname: $fullname, avatar: $avatar)';

  @override
  bool operator ==(covariant Follow other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.fullname == fullname &&
      other.avatar == avatar;
  }

  @override
  int get hashCode => email.hashCode ^ fullname.hashCode ^ avatar.hashCode;
}
