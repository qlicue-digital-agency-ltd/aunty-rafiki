import 'package:flutter/material.dart';

enum Bumps { DefaultBumps, UserBumps }

class BabyBump {
  final int id;
  final String image;

  BabyBump({
    @required this.id,
    @required this.image,
  });
}
