import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'img.dart';

class Recipe {
  final int id;
  final String title;
  final String subtitle;
  final String ingredients;
  final String howToPrepare;
  final String alternativeFood;
  List<Img> images;

  Recipe({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.ingredients,
    @required this.howToPrepare,
    @required this.alternativeFood,
    @required this.images,
  });

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Recipe.fromMap(Map<String, dynamic> map)
      : assert(map['recipe_id'] != null),
        id = map['recipe_id'],
        title = map['recipe_title'],
        subtitle = map['recipe_subtitle'],
        ingredients = map['recipe_ingredients'],
        howToPrepare = map['recipe_how_to_prepare'],
        alternativeFood = map['recipe_alternative_food'],
        images = map['images'] != null
            ? (map['images'] as List).map((i) => Img.fromMap(i)).toList()
            : null;
}
