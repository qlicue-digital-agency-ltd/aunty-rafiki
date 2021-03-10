import 'package:aunty_rafiki/models/recipe.dart';
import 'package:flutter/material.dart';

class Food {
  int id;
  String title;
  String subtitle;
  String cover;
  List<Recipe> recipes;

  Food({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.cover,
    @required this.recipes,
  });

  Food.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        cover = map['cover'],
        recipes = map['recipes'] != null
            ? (map['recipes'] as List).map((i) => Recipe.fromMap(i)).toList()
            : null;
}
