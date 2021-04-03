import 'package:aunty_rafiki/models/author.dart';
import 'package:flutter/material.dart';

import 'img.dart';

class Post {
  int id;
  String title;
  String body;
  String time;
  int authorId;
  int likeCount;
  bool likedByMe;
  List<Img> images;
  Author author;

  Post(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.time,
      @required this.authorId,
      @required this.likeCount,
      @required this.likedByMe,
      this.images});

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
      : assert(map['post_id'] != null),
        assert(map['post_title'] != null),
        id = map['post_id'],
        title = map['post_title'],
        body = map['post_content'],
        time = map['time'],
        author = Author.fromMap(map['author']),
        images = map['images'] != null
            ? (map['images'] as List).map((i) => Img.fromMap(i)).toList()
            : null;
}
