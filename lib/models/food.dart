import 'package:aunty_rafiki/models/recipe.dart';
import 'package:flutter/material.dart';

import 'img.dart';

class Food {
  int id;
  String title;
  String subtitle;
  List<Img> images;
  List<Recipe> recipes;

  Food({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.recipes,
    @required this.images,
  });

  Food.fromMap(Map<String, dynamic> map)
      : assert(map['food_id'] != null),
        id = map['food_id'],
        title = map['food_title'],
        subtitle = map['food_subtitle'],
        recipes = map['recipes'] != null
            ? (map['recipes'] as List).map((i) => Recipe.fromMap(i)).toList()
            : null,
        images = map['images'] != null
            ? (map['images'] as List).map((i) => Img.fromMap(i)).toList()
            : null;
}
