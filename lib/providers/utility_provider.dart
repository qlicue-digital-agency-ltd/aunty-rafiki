import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        _setTitle = "Blood Level";
        break;
      case 3:
        _setTitle = "More";
        break;
      default:
        _setTitle = "Tracker";
    }
  }

  String formatDate(DateTime time) {
    DateFormat template;

    if (DateTime.now().difference(time).inSeconds < 60) {
      return "now";
    }
    if (DateTime.now().difference(time).inSeconds > 60 &&
        DateTime.now().difference(time).inMinutes < 60) {
      return DateTime.now().difference(time).inMinutes.toString() +
          " minutes ago";
    }
    if (DateTime.now().difference(time).inMinutes > 60 &&
        DateTime.now().difference(time).inHours < 24) {
      return DateTime.now().difference(time).inHours.toString() + " hours ago";
    }
    if (DateTime.now().difference(time).inDays == 1) {
      return "Yesterday";
    }
    print("++++++++++++++++++++++----------+++++++++++++++++++++");
    print(DateTime.now().difference(time).inDays);
    print("++++++++++++++++++++++----------+++++++++++++++++++++");
    template = DateFormat('EEE, MMM d, ' 'yy');
    return template.format(time);
  }
}
