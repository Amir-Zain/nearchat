import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatUser {
  String? name;

  String? uid;

  String? email;

  // String? profilepic;

  ChatUser({
    this.email,
    this.uid,
    // this.profilepic,
    this.name,
  });
  factory ChatUser.fromJson(Map<String, dynamic> parsedJson) {
    return ChatUser(
      uid: parsedJson['uid'].toString(),
      name: parsedJson['name'].toString(),
      email: parsedJson['email'].toString(),
      // profilepic: parsedJson['profilepic'].toString()
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        // "profilepic": profilepic,
      };
}
