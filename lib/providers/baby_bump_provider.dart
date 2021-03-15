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
    notifyListeners();
  }
}
