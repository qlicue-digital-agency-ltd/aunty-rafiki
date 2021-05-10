import 'dart:async';

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NameScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const NameScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController _nameEditingController = TextEditingController();

  GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
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
    return Form(
        key: _nameFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              Languages.of(context).labelMotherNameQuestion,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            IconTextField(
              icon: Icons.person,
              textEditingController: _nameEditingController,
              title: Languages.of(context).labelFullName,
              validator: (val) {
                if (val.isEmpty)
                  return 'Enter the your name';
                else
                  return null;
              },
            ),
            SizedBox(
              height: 10,
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
                  if (_nameFormKey.currentState.validate()) {
                    print('save the data');
                    _authProvider
                        .updateUsername(
                            displayName: _nameEditingController.text,
                            hasProfile: false)
                        .then((value) {
                      setState(() {
                        _isPressed = false;
                      });
                      if (!value) {
                        widget._changePage(widget._currentPage + 1);
                        _configProvider.setConfigurationStep =
                            Configuration.NameScreenStepDone;
                      }
                    });
                  } else {
                    print('Issue the data');
                  }
                }
              },
              isPressed: _isPressed,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ));
  }
}
