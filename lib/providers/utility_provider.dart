import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/term.dart';
import 'package:aunty_rafiki/service/shared/shared_preference.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class UtilityProvider with ChangeNotifier {
  /// Shared preference DB
  SharedPref _sharedPref = SharedPref();

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

  bool _isNewToApp = true;

  Future<bool> get isNewToApp async {
    await _sharedPref.readBoolean('isNewToApp').then((status) {
      _isNewToApp = status;
    });

    return _isNewToApp;
  }

  set setIsNewToAppStatus(bool status) {
    _isNewToApp = status;
    _sharedPref.saveBoolean('isNewToApp', status);
    notifyListeners();
  }

  List<TermModel> _checkBoxList = TermModel.getUsers();
  List<TermModel> get checkBoxList => _checkBoxList;

  set setItemChange(int index) {
    _checkBoxList[index].isCheck = !_checkBoxList[index].isCheck;
    //check for terms state..
    checkForAllTerms();

    notifyListeners();
  }

  checkForAllTerms() {
    if (_checkBoxList.where((element) => element.isCheck).length ==
        _checkBoxList.length) {
      _configTerms = ConfigTerms.ALL;
    } else if (_checkBoxList.where((element) => element.isCheck).length > 0) {
      _configTerms = ConfigTerms.PARTIAL;
    } else {
      _configTerms = ConfigTerms.NON;
    }
    notifyListeners();
  }

  //TERMS configuration...
  ConfigTerms _configTerms = ConfigTerms.NON;

//getters...
  ConfigTerms get configTerms => _configTerms;

//select all terms..
  selectAllTerms() {
    _checkBoxList.forEach((element) {
      element.isCheck = true;
    });

    //check for terms state..
    checkForAllTerms();

    notifyListeners();
  }
}
