
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberPicker extends StatelessWidget {
  //current picker value
  final int _currentValue;
  // title
  final String _title;
  // subtitle
  final String _subtitle;
  //return function
  final Function(int) _onChanged;
  //minimum value
  final int _miniValue;
  //maximum value
  final int _maxValue;

  const CustomNumberPicker(
      {Key key,
      @required Function onChanged,
      @required String title,
      String subtitle,
      @required int currentValue,
      @required int miniValue,
      @required int maxValue})
      : _title = title,
        _subtitle = subtitle,
        _onChanged = onChanged,
        _currentValue = currentValue,
        _maxValue = maxValue,
        _miniValue = miniValue,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
     
        SizedBox(
          height:10,
        ),
        Theme(
          data: theme.copyWith(
              accentColor: Colors.black, // highlted color
              textTheme: theme.textTheme.copyWith(
                headline5: theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold), //other highlighted style
                bodyText2: theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold), //not highlighted styles
              )),
          child: Container(
            width: double.infinity,
            child: NumberPicker.integer(
                listViewWidth: double.infinity,
                decoration:
                    BoxDecoration(color: Colors.pink[100].withOpacity(0.5)),
                // ignore: deprecated_member_use

                selectedTextStyle: theme.textTheme.headline1.copyWith(
                    color: theme.accentColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                initialValue: _currentValue,
                minValue: _miniValue,
                maxValue: _maxValue,
                onChanged: _onChanged),
          ),
        ),
      ],
    );
  }
}
