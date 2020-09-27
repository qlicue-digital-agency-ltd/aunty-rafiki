import 'package:flutter/cupertino.dart';

import 'package:aunty_rafiki/models/baby_bump.dart';

class BabyBumpProvider extends ChangeNotifier {
  int _tabIndex = 1;

  // getter
  int get tabIndex => _tabIndex;

  // setter
  void setTabIndex(int index) {
    _tabIndex = index + 1;
    notifyListeners();
  }

  // baby bump mock data
  List<BabyBump> babyBumps = [
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
}
