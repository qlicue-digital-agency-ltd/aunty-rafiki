import 'package:flutter/material.dart';

enum Bumps { DefaultBumps, UserBumps }

class BabyBump {
  final int id;
  String image;
  final Bumps bumpType;

  BabyBump({
    @required this.id,
    @required this.image,
    @required this.bumpType,
  });
}
