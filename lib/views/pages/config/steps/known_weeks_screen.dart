import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class KnownWeeksScreen extends StatefulWidget {
  @override
  _KnownWeeksScreenState createState() => _KnownWeeksScreenState();
}

class _KnownWeeksScreenState extends State<KnownWeeksScreen> {
  int _currentPickerWeekValue = 4;
  int _currentPickerYearValue = 1988;

  UtilityProvider utilityProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
      utilityProvider.setColorKnownPregnancy1 = Colors.pink;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Step ${_utilityProvider.stepKnownPregnancy} out of 2',
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
                  color: _utilityProvider.colorKnownPregnancy1,
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
                  color: _utilityProvider.colorKnownPregnancy2,
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
          _utilityProvider.stepKnownPregnancy == 1
              ? Column(
                  children: [
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
                                fontWeight:
                                    FontWeight.bold), //other highlighted style
                            bodyText2: theme.textTheme.headline5.copyWith(
                                fontWeight:
                                    FontWeight.bold), //not highlighted styles
                          )),
                      child: Container(
                        width: double.infinity,
                        child: NumberPicker.integer(
                            listViewWidth: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.pink[100].withOpacity(0.5)),
                            // ignore: deprecated_member_use

                            selectedTextStyle: theme.textTheme.headline1
                                .copyWith(
                                    color: theme.accentColor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                            initialValue: _currentPickerWeekValue,
                            minValue: 4,
                            maxValue: 43,
                            onChanged: (newValue) => setState(
                                () => _currentPickerWeekValue = newValue)),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      'what year were you born?',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      'Telling us your age will help us give us precise information',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 160,
                    ),
                    Theme(
                      data: theme.copyWith(
                          accentColor: Colors.black, // highlted color
                          textTheme: theme.textTheme.copyWith(
                            headline5: theme.textTheme.headline5.copyWith(
                                fontWeight:
                                    FontWeight.bold), //other highlighted style
                            bodyText2: theme.textTheme.headline5.copyWith(
                                fontWeight:
                                    FontWeight.bold), //not highlighted styles
                          )),
                      child: Container(
                        width: double.infinity,
                        child: NumberPicker.integer(
                            listViewWidth: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.pink[100].withOpacity(0.5)),
                            // ignore: deprecated_member_use

                            selectedTextStyle: theme.textTheme.headline1
                                .copyWith(
                                    color: theme.accentColor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                            initialValue: _currentPickerYearValue,
                            minValue: 1931,
                            maxValue: 2008,
                            onChanged: (newValue) => setState(
                                () => _currentPickerYearValue = newValue)),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
