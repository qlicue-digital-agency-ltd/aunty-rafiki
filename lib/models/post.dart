import 'package:flutter/material.dart';

class Post {
  int id;
  String title;
  String body;
  String time;
  int authorId;
  int likeCount;
  bool likedByMe;
  String image;

  Post(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.time,
      @required this.authorId,
      @required this.likeCount,
      @required this.likedByMe,
      this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'body': body,
      'time': time,
      'author_id': authorId
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Post.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['body'] != null),
        id = map['id'],
        title = map['title'],
        body = map['body'],
        time = map['time'],
        image = map['image'],
        likeCount = map['likes_count'],
        likedByMe = map['liked_by_me'],
        authorId = map['user_id'];
}
