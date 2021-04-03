import 'package:flutter/material.dart';

class Img {
  int id;
  String description;
  String url;

  Img({
    @required this.id,
    @required this.description,
    @required this.url,
  });
  Img.fromMap(Map<String, dynamic> map)
      : assert(map['image_id'] != null),
        id = map['image_id'],
        description = map['image_description'],
        url = map['image_url'];
}
