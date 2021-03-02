import 'package:flutter/material.dart';

import 'author.dart';

class Post {
  final int id;
  final String title;
  final String body;
  final String time;
  final int authorId;
  final int likeCount;
  final bool likedByMe;
  String image;
  Author author;

  Post(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.time,
      @required this.authorId,
      @required this.likeCount,
      @required this.likedByMe,
      @required this.author,
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
        authorId = int.parse(map['author_id']),
        author = Author.fromMap(map['author']);
}
