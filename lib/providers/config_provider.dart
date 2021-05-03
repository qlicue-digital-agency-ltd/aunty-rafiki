import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/service/shared/shared_preference.dart';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:flutter/material.dart';

class ConfigProvider with ChangeNotifier {
  ConfigProvider() {
    getAppConfigurationStep();
    fetchConfigurations().then((value) {
      if (_fetchedConfiguration == Configuration.NameScreenStepDone) {
        changePage(2);
      }
    });
  }

  int _currentPregPage = 1;
  int _currentUnknownPregPage = 1;

  /// Shared preference DB
  SharedPref _sharedPref = SharedPref();

  //app configuration...
  Configuration _appConfigurationStep = Configuration.Non;

  Configuration _fetchedConfiguration = Configuration.Non;

  ///setter for configuration
  set setConfigurationStep(Configuration step) {
    _appConfigurationStep = step;

    String _result = EnumToString.convertToString(_appConfigurationStep);

    _sharedPref.saveStringleString('configurationStep', _result);

    notifyListeners();
  }

  ///getter for configuration ...
  Future<void> getAppConfigurationStep() async {
    final _config = await _sharedPref.readStringleString('configurationStep');
    print(_config);
    if (_config != null) {
      _appConfigurationStep =
          EnumToString.fromString(Configuration.values, _config);
    }
    notifyListeners();
  }

  Configuration get currentConfigurationStep => _appConfigurationStep;

  int get currentPregPage => _currentPregPage;
  int get currentUnknownPregPage => _currentUnknownPregPage;
  // PageController get pageController => _pageController;

  Configuration get fetchedConfiguration => _fetchedConfiguration;

  Future<void> fetchConfigurations() async {
    final _config = await _sharedPref.readStringleString('configurationStep');
    print(_config);
    if (_config != null) {
      _fetchedConfiguration =
          EnumToString.fromString(Configuration.values, _config);
    }
    notifyListeners();
  }

  void changePage(int index) {
    _currentPregPage = index + 1;
    notifyListeners();
  }

  void backPage() {
    if (_currentPregPage == 2) {
      changePage(0);
    } else if (_currentPregPage == 3) {
      changePage(1);
    } else if (_currentPregPage == 4) {
      changePage(2);
    } else if (_currentPregPage == 5) {
      changePage(3);
    } else {}
  }
}
