import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_string_dropdown.dart';
import 'package:aunty_rafiki/views/components/buttons/number_counter.dart';

import 'package:flutter/material.dart';
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
  String _miscarriage = "NO";
  int _miscarriageAge = 1;
  int _births = 0;
  int _operationBirths = 0;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
     final _configProvider = Provider.of<ConfigProvider>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 10,
        ),
        NumberCounter(
          counter: _gravida,
          onTap: (val) {
            setState(() {
              _gravida = val;
            });
          },
          title: 'Gravida',
          context: context,
        ),
        SizedBox(
          height: 10,
        ),
        CustomStringDropdown(
          title: 'Ever had a miscarriage?',
          value: _miscarriage,
          items: ["NO", "YES"],
          onChange: (value) {
            setState(() {
              _miscarriage = value;
              if (_miscarriage == "NO") {
                _miscarriageAge = 0;
              }
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        _miscarriage == "YES"
            ? NumberCounter(
                counter: _miscarriageAge,
                onTap: (val) {
                  setState(() {
                    _miscarriageAge = val;
                  });
                },
                title: 'How many weeks was the pregnancy upon miscarriage?',
                context: context,
              )
            : Container(),
        _miscarriage == "YES"
            ? SizedBox(
                height: 10,
              )
            : Container(),
        NumberCounter(
          counter: _births,
          onTap: (val) {
            setState(() {
              _births = val;
            });
          },
          title: 'How many times have you given birth?',
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
                    _operationBirths = val;
                  });
                },
                title: 'How many times did you give birth by operation?',
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
          title: 'Next',
          onPressed: () {
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
          },
          isPressed: _isPressed,
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
