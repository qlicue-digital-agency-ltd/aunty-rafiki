import 'dart:io';

import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/pages/config/steps/known_weeks_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/unknown_weeks_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class StepsPage extends StatefulWidget {
  @override
  _StepsPageState createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  bool _isSelected = false;

  void itemChange(bool val) {
    setState(() {
      _isSelected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
              onPressed: () {
                if (_utilityProvider.knownPregnancy) {
                  if (_utilityProvider.stepKnownPregnancy == 2) {
                    _utilityProvider.setStepKnownPregnancy = 1;
                    _utilityProvider.setColorKnownPregnancy2 =
                        Colors.transparent;
                  } else {
                    Navigator.pop(context);
                  }
                }
              }),
          title: Text('Steps')),
      body: _utilityProvider.knownPregnancy
          ? KnownWeeksScreen()
          : UnknownWeeksScreen(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              if (_utilityProvider.stepKnownPregnancy == 1)
                ListTile(
                    onTap: () {
                      itemChange(!_isSelected);
                      _utilityProvider.setKnownPregnancy =
                          !_utilityProvider.knownPregnancy;
                    },
                    leading: Checkbox(
                        value: _isSelected,
                        onChanged: (bool val) {
                          itemChange(val);
                          _utilityProvider.setKnownPregnancy =
                              !_utilityProvider.knownPregnancy;
                        }),
                    title: Text("i don't remember")),
              FlatButton(
                  color: Colors.pink,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_utilityProvider.knownPregnancy) {
                      if (_utilityProvider.stepKnownPregnancy == 1) {
                        _utilityProvider.setStepKnownPregnancy = 2;
                        _utilityProvider.setColorKnownPregnancy2 = Colors.pink;
                      } else {}
                    }
                  },
                  child: Text('Next')),
            ],
          ),
        ),
      ),
    );
  }
}
