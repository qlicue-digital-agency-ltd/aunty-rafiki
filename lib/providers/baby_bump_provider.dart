import 'package:flutter/cupertino.dart';

import 'package:aunty_rafiki/models/baby_bump.dart';

import '../models/baby_bump.dart';

class BabyBumpProvider extends ChangeNotifier {
  int _tabIndex = 1;
  bool _bumpButtonsToggle = false;

  var _bumpType = Bumps.DefaultBumps;

  // getter
  int get tabIndex => _tabIndex;
  Bumps get bumpType => _bumpType;
  bool get bumpButtonToggle => _bumpButtonsToggle;

  List<BabyBump> get defaultBumps => _defaultBumps.toList();
  List<BabyBump> get myBumps => _myBumps.toList();

  // setter

  void setBumpButtonToggle(bool val) {
    _bumpButtonsToggle = val;
    notifyListeners();
  }

  void setTabIndex(int index) {
    _tabIndex = index + 1;
    notifyListeners();
  }

  // update bump type
  void updateBumpType(Bumps bumpType) {
    _bumpType = bumpType;
    notifyListeners();
  }

  // update image value
  void updateImageValue(int index, String path) {
    _myBumps[index].image = path;
    notifyListeners();
  }

  // mock data
  // default app bumps
  List<BabyBump> _defaultBumps = [
    BabyBump(
        id: 1,
        image: 'assets/baby/comp_rm_photo_ultrasound_20_weeks.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 2,
        image: 'assets/baby/getty_rm_photo_of_4_week_fetus.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 3,
        image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 4,
        image: 'assets/baby/istock_photo_of_pregnancy.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 5,
        image: 'assets/baby/nilsson_rm_photo_28_weeks.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 6,
        image: 'assets/baby/nilsson_rm_photo_36_week_fetus.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 7,
        image: 'assets/baby/nilsson_rm_photo_of_20_week_fetus.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 8,
        image: 'assets/baby/phototake_newborn_at_birth.jpg',
        bumpType: Bumps.DefaultBumps),
    BabyBump(
        id: 9,
        image: 'assets/baby/phototake_photo_of_8_week_fetus_circle.jpg',
        bumpType: Bumps.DefaultBumps),
  ];

  // user bumps
  List<BabyBump> _myBumps = [
    BabyBump(id: 1, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 2, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 3, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 4, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 5, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 6, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 7, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 8, image: '', bumpType: Bumps.UserBumps),
    BabyBump(id: 9, image: '', bumpType: Bumps.UserBumps),
  ];
}
