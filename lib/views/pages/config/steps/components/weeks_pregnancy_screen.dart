import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/mother_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/picker/custom_number_picker.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeeksPregnancyScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const WeeksPregnancyScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);
  @override
  _WeeksPregnancyScreenState createState() => _WeeksPregnancyScreenState();
}

class _WeeksPregnancyScreenState extends State<WeeksPregnancyScreen> {
  int _weeksOfPregnancy = 3;
  int _daysOfPregnancy = 0;
  bool _isSelected = false;
  bool _isPressed = false;

  String _date = '';

  void itemChange(bool val) {
    setState(() {
      _isSelected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _configProvider = Provider.of<ConfigProvider>(context);
    final _motherProvider = Provider.of<MotherProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        !_isSelected
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'WEEKS',
                            style: TextStyle(fontSize: 20),
                          ),
                          CustomNumberPicker(
                            title: '',
                            currentValue: _weeksOfPregnancy,
                            onChanged: (value) {
                              setState(() {
                                _weeksOfPregnancy = value;
                              });
                            },
                            miniValue: 3,
                            maxValue: 43,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'DAYS',
                            style: TextStyle(fontSize: 20),
                          ),
                          CustomNumberPicker(
                            title: '',
                            currentValue: _daysOfPregnancy,
                            onChanged: (value) {
                              setState(() {
                                _daysOfPregnancy = value;
                              });
                            },
                            miniValue: 0,
                            maxValue: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: _isSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: Column(
                    children: [
                      Text(
                        "Don't worry Auntie Rafiki will help you determine the pregnancy week in another way ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(height: 25),
                      Text(
                        "Select the date of the first day of your last menstrual period ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 240, 240, 1),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: DateTimePicker(
                                initialValue: '',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Date',
                                dateMask: 'd MMM, yyyy',
                                onChanged: (val) => print(val),
                                validator: (val) {
                                  print(val);
                                  setState(() {
                                    if (val != null) _date = val;
                                  });
                                  return null;
                                },
                                onSaved: (val) => print(val),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 240, 240, 1),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: ListTile(
                  onTap: () {
                    itemChange(!_isSelected);
                  },
                  leading: Checkbox(
                      value: _isSelected,
                      onChanged: (bool val) {
                        itemChange(val);
                      }),
                  title: Text("I don't remember")),
            ),
            SizedBox(
              height: 5,
            ),
            CustomRaisedButton(
              title: 'Next',
              onPressed: () {
                setState(() {
                  _isPressed = true;
                });
                if (_isSelected) {
                  _authProvider
                      .updateConceptionDate(conceptionDate: _date)
                      .then((value) {
                    if (!value) {
                      //post pregancy date to server...
                      _motherProvider
                          .postPregnancy(conceptionDate: _date)
                          .then((value) {
                        widget._changePage(widget._currentPage + 1);
                        _configProvider.setConfigurationStep =
                            Configuration.WeeksPregnancyScreenStepDone;
                      });
                    }
                    setState(() {
                      _isPressed = false;
                    });
                  });
                } else {
                  DateTime today = DateTime.now();
                  DateTime daysAgo = today.subtract(Duration(
                      days: (_weeksOfPregnancy * 7 + _daysOfPregnancy)));
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final String _formatted = formatter.format(daysAgo);
                  print(_formatted);
                  _motherProvider
                      .postPregnancy(conceptionDate: _formatted)
                      .then((value) {});

                  _authProvider
                      .updateConceptionDate(conceptionDate: _formatted)
                      .then((value) {
                    if (!value) {
                      widget._changePage(widget._currentPage + 1);
                      _configProvider.setConfigurationStep =
                          Configuration.WeeksPregnancyScreenStepDone;
                    }
                    setState(() {
                      _isPressed = false;
                    });
                  });
                }
              },
              isPressed: _isPressed,
            ),
          ],
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
