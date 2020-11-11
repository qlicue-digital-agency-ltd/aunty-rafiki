
import 'package:flutter/material.dart';


class UtilityProvider with ChangeNotifier {
  ///variables
  int _currentIndex = 0;

  String _title = 'Tracker';

  ///setters
  set _setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();

    ///notifies the provider on change of the value
  }

  set _setTitle(String title) {
    _title = title;

    notifyListeners();
  }

  ///getters
  int get currentIndex => _currentIndex;
  String get title => _title;

  ///
  ///extra function...
  ///
  ///select current tab
  selectTab(int index) {
    _setCurrentIndex = index;

    switch (index) {
      case 0:
        _setTitle = "Tracker";
        break;
      case 1:
        _setTitle = "Chats";
        break;
      case 2:
        _setTitle = "Baby Bump";
        break;
      case 3:
        _setTitle = "More";
        break;
      default:
        _setTitle = "Tracker";
    }
  }
}
