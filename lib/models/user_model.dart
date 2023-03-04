import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChatUser {
  String? name;
  String? uid;
  String? email;
  String? avatar;
  String? discription;
  String? interests;
  String? age;

  ChatUser({
    this.email,
    this.uid,
    this.avatar,
    this.name,
    this.discription,
    this.interests,
    this.age,
  });
  factory ChatUser.fromJson(Map<String, dynamic> parsedJson) {
    return ChatUser(
      uid: parsedJson['uid'].toString(),
      name: parsedJson['name'].toString(),
      email: parsedJson['email'].toString(),
      avatar: parsedJson['avatar'].toString(),
      discription: parsedJson['discription'].toString(),
      interests: parsedJson['interests'].toString(),
      age: parsedJson['age'].toString(),
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "avatar": avatar,
        "discription": discription,
        "interests": interests,
        "age": age,
      };
}
