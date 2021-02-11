import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/picker/custom_number_picker.dart';
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
  int _weeksOfPregnancy = 4;
  bool _isSelected = false;
  bool _isPressed = false;
  void itemChange(bool val) {
    setState(() {
      _isSelected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
     final _configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        !_isSelected
            ? CustomNumberPicker(
                title: 'How many weeks pregnant are you?',
                currentValue: _weeksOfPregnancy,
                onChanged: (value) {
                  setState(() {
                    _weeksOfPregnancy = value;
                  });
                },
                miniValue: 4,
                maxValue: 43,
              )
            : Center(
                child: AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: _isSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: Text(
                    "Don't worry aunty rafiki will help you determine the pregnancy week in another way ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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
                _authProvider
                    .updatePregnancyWeeks(
                        pregnancyWeeks: _isSelected ? 0 : _weeksOfPregnancy)
                    .then((value) {
                  setState(() {
                    _isPressed = false;
                  });
                  if (!value) {
                    widget._changePage(widget._currentPage + 1);
                    _configProvider.setConfigurationStep =
                        Configuration.WeeksPregnancyScreenStepDone;
                  }
                });

            
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
