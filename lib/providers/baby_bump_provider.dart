import 'package:flutter/cupertino.dart';

class BabyBumpProvider extends ChangeNotifier {
  int _tabIndex = 1;

  // getter
  int get tabIndex => _tabIndex;

  // setter
  void setTabIndex(int index) {
    _tabIndex = index + 1;
    notifyListeners();
  }
}
