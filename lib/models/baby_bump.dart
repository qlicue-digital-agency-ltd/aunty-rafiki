import 'package:flutter/material.dart';

class BabyBump {
  final int id;
  final String image;

  BabyBump({
    @required this.id,
    @required this.image,
  });
}

List<BabyBump> babyBump = [
  BabyBump(
    id: 1,
    image: 'assets/baby/comp_rm_photo_ultrasound_20_weeks.jpg',
  ),
  BabyBump(
    id: 2,
    image: 'assets/baby/getty_rm_photo_of_4_week_fetus.jpg',
  ),
  BabyBump(
    id: 3,
    image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
  ),
  BabyBump(
    id: 4,
    image: 'assets/baby/istock_photo_of_pregnancy.jpg',
  ),
  BabyBump(
    id: 5,
    image: 'assets/baby/nilsson_rm_photo_28_weeks.jpg',
  ),
  BabyBump(
    id: 6,
    image: 'assets/baby/nilsson_rm_photo_36_week_fetus.jpg',
  ),
  BabyBump(
    id: 7,
    image: 'assets/baby/nilsson_rm_photo_of_20_week_fetus.jpg',
  ),
  BabyBump(
    id: 8,
    image: 'assets/baby/phototake_newborn_at_birth.jpg',
  ),
  BabyBump(
    id: 9,
    image: 'assets/baby/phototake_photo_of_8_week_fetus_circle.jpg',
  ),
];
