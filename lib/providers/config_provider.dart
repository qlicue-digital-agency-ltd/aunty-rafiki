import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/service/shared/shared_preference.dart';

import 'package:enum_to_string/enum_to_string.dart';

import 'package:flutter/material.dart';

class ConfigProvider with ChangeNotifier {
  /// Shared preference DB
  SharedPref _sharedPref = SharedPref();

  //app configuration...
  Configuration _appConfigurationStep = Configuration.Non;

  ///setter for configuration
  set setConfigurationStep(Configuration step) {
    _appConfigurationStep = step;

    String _result = EnumToString.convertToString(_appConfigurationStep);

    _sharedPref.saveStringleString('configurationStep', _result);

    notifyListeners();
  }

  ///getter for configuration ...
  Future<Configuration> get appConfigurationStep async {
    final _config = await _sharedPref.readStringleString('configurationStep');
    print(_config);
    if (_config != null) {
      _appConfigurationStep =
          EnumToString.fromString(Configuration.values, _config);
    }
    return _appConfigurationStep;
  }
}
