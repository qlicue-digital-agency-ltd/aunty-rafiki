import 'dart:async';

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_string_dropdown.dart';
import 'package:aunty_rafiki/views/components/buttons/number_counter.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MotherhoodInfoScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const MotherhoodInfoScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);
  @override
  _MotherhoodInfoScreenState createState() => _MotherhoodInfoScreenState();
}

class _MotherhoodInfoScreenState extends State<MotherhoodInfoScreen> {
  int _gravida = 1;
  String _miscarriage = "";
  int _miscarriageAge = 1;
  int _births = 0;
  int _operationBirths = 0;
  bool _isPressed = false;

  ///check for internet connection
  String _connectionStatus = 'unknown';

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'unknown');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _configProvider = Provider.of<ConfigProvider>(context);

    List<String> _boolStrings = [
      Languages.of(context).labelYes,
      Languages.of(context).labelNo
    ];
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        NumberCounter(
          counter: _gravida,
          onTap: (val) {
            setState(() {
              if (_gravida > 0) {
                if (val != null) _gravida += val;
              } else if (val > 0) {
                if (val != null) _gravida += val;
              }
            });
          },
          title: Languages.of(context).labelGravida,
          context: context,
        ),
        SizedBox(
          height: 10,
        ),
        CustomStringDropdown(
          title: Languages.of(context).labelEverHadAMiscarriage,
          value: _boolStrings.contains(_miscarriage)
              ? _miscarriage
              : Languages.of(context).labelNo,
          items: [_boolStrings[1], _boolStrings[0]],
          onChange: (value) {
            setState(() {
              if (value != null) _miscarriage = value;
              if (_miscarriage == _boolStrings[1]) {
                _miscarriageAge = 0;
              }
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        _miscarriage == _boolStrings[0]
            ? NumberCounter(
                counter: _miscarriageAge,
                onTap: (val) {
                  setState(() {
                    if (_miscarriageAge > 0) {
                      if (val != null) _miscarriageAge += val;
                    } else if (val > 0) {
                      if (val != null) _miscarriageAge += val;
                    }
                  });
                },
                title: Languages.of(context).labelWeeksOfMiscarriage,
                context: context,
              )
            : Container(),
        _miscarriage == _boolStrings[0]
            ? SizedBox(
                height: 10,
              )
            : Container(),
        NumberCounter(
          counter: _births,
          onTap: (val) {
            setState(() {
              if (_births > 0) {
                if (val != null) _births += val;
              } else if (val > 0) {
                if (val != null) _births += val;
              }
            });
          },
          title: Languages.of(context).labelNumberOfTimesYouGaveBirth,
          context: context,
        ),
        SizedBox(
          height: 10,
        ),
        _births > 0
            ? NumberCounter(
                counter: _operationBirths,
                onTap: (val) {
                  setState(() {
                    if (_operationBirths > 0) {
                      if (val != null) _operationBirths += val;
                    } else if (val > 0) {
                      if (val != null) _operationBirths += val;
                    }
                  });
                },
                title: Languages.of(context).labelBirthByOperation,
                context: context,
              )
            : Container(),
        _births > 0
            ? SizedBox(
                height: 10,
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
        CustomRaisedButton(
          title: Languages.of(context).labelNextButton,
          onPressed: () {
            if (_connectionStatus == 'ConnectivityResult.none' ||
                _connectionStatus == 'unknown') {
              Fluttertoast.showToast(
                  msg: Languages.of(context).labelNoItemTileInternet,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              setState(() {
                _isPressed = true;
              });
              _authProvider
                  .updateMotherhoodInfo(
                      gravida: _gravida,
                      miscarriage: _miscarriage,
                      miscarriageWeeks: _miscarriageAge,
                      numberOfDeliveries: _births,
                      numberOfNormalDeliveries: _operationBirths,
                      numberOfOperationDeliveries: _births - _operationBirths)
                  .then((value) {
                setState(() {
                  _isPressed = false;
                });
                if (!value) {
                  widget._changePage(widget._currentPage + 1);
                  _configProvider.setConfigurationStep =
                      Configuration.MotherhoodInfoScreenStepDone;
                }
              });
            }
          },
          isPressed: _isPressed,
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
