import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class KnownWeeksScreen extends StatefulWidget {
  @override
  _KnownWeeksScreenState createState() => _KnownWeeksScreenState();
}

class _KnownWeeksScreenState extends State<KnownWeeksScreen> {
  int _currentPickerValue = 4;
  int _step = 1;
  bool _isSelected = false;
  Color _color1 = Colors.transparent;
  Color _color2 = Colors.transparent;
  void itemChange(bool val) {
    setState(() {
      _isSelected = val;
    });
  }

  @override
  void initState() {
    setState(() {
      _color1 = Colors.pink;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Step $_step out of 2',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[300],
            ),
            margin: EdgeInsets.only(left: 40, right: 40),
            child: Row(children: [
              Expanded(
                  child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: _color1,
                ),
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                height: 5,
              )),
              Expanded(
                  child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: _color2,
                ),
                height: 5,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              ))
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'How many weeks pregnant are you?',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 160,
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
                  initialValue: _currentPickerValue,
                  minValue: 4,
                  maxValue: 43,
                  onChanged: (newValue) =>
                      setState(() => _currentPickerValue = newValue)),
            ),
          ),
        ],
      ),
    );
  }
}
