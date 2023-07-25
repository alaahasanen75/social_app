import 'package:flutter/cupertino.dart';

class PostModel {
  String? name;
  String? uid;
  @required
  String? image;
  String? text;
  String? dateTime;
  String? postImage;

  PostModel(
      {this.name,
      this.dateTime,
      this.uid,
      this.text,
      this.postImage,
      this.image});
  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    image = json['image'];
    text = json['text'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name!,
      'uid': uid!,
      ' image': image,
      'text': text,
      'dateTime': dateTime,
      'postImage': postImage,
    };
  }
}
