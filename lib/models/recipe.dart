import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Recipe {
  final int id;
  final String title;
  final String subtitle;
  final String ingredients;
  final String howToPrepare;
  final String alternativeFood;
  final String cover;

  Recipe({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.ingredients,
    @required this.howToPrepare,
    @required this.alternativeFood,
    @required this.cover,
  });

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Recipe.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        subtitle = map['subtitle'],
        ingredients = map['ingredients'],
        howToPrepare = map['how_to_prepare'],
        alternativeFood = map['alternative_food'],
        cover = map['cover'];
}
