import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/radio_label_button.dart';
import 'package:aunty_rafiki/views/components/cards/calendar_card.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class UnknownWeeksScreen extends StatefulWidget {
  @override
  _UnknownWeeksScreenState createState() => _UnknownWeeksScreenState();
}

class _UnknownWeeksScreenState extends State<UnknownWeeksScreen> {
  UtilityProvider utilityProvider;
  int _isRadioSelected = 1;
  int _currentPickerYearValue = 1988;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      utilityProvider = Provider.of<UtilityProvider>(context, listen: false);
      utilityProvider.setColorUnknownPregnancy1 = Colors.pink;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            'Step ${_utilityProvider.stepUnknownPregnancy} out of 4',
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
                  color: _utilityProvider.colorUnknownPregnancy1,
                ),
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                height: 5,
              )),
              Expanded(
                  child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: _utilityProvider.colorUnknownPregnancy2,
                ),
                height: 5,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              )),
              Expanded(
                  child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: _utilityProvider.colorUnknownPregnancy3,
                ),
                height: 5,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              )),
              Expanded(
                  child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: _utilityProvider.colorUnknownPregnancy4,
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
          _utilityProvider.stepUnknownPregnancy == 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Don't worry aunty rafiki will help you determine the pregnancy week in another way ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )
              : _utilityProvider.stepUnknownPregnancy == 2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Select the method of determining yo week.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        LinkedLabelRadio(
                          label: 'I know the first day of my last period',
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          value: 1,
                          groupValue: _isRadioSelected,
                          onChanged: (int newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinkedLabelRadio(
                          label: 'I know the expected due date',
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          value: 2,
                          groupValue: _isRadioSelected,
                          onChanged: (int newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinkedLabelRadio(
                          label: 'I know the date of conception',
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          value: 3,
                          groupValue: _isRadioSelected,
                          onChanged: (int newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                      ],
                    )
                  : _utilityProvider.stepUnknownPregnancy == 3
                      ? Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                _isRadioSelected == 1
                                    ? 'When did your last period start?'
                                    : _isRadioSelected == 2
                                        ? 'Select the expected due date'
                                        : 'Select date of conception',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CalendarCard(),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'what year were you born?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                                    headline5: theme.textTheme.headline5
                                        .copyWith(
                                            fontWeight: FontWeight
                                                .bold), //other highlighted style
                                    bodyText2: theme.textTheme.headline5
                                        .copyWith(
                                            fontWeight: FontWeight
                                                .bold), //not highlighted styles
                                  )),
                              child: Container(
                                width: double.infinity,
                                child: NumberPicker.integer(
                                    listViewWidth: double.infinity,
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.pink[100].withOpacity(0.5)),
                                    // ignore: deprecated_member_use

                                    selectedTextStyle: theme.textTheme.headline1
                                        .copyWith(
                                            color: theme.accentColor,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                    initialValue: _currentPickerYearValue,
                                    minValue: 1931,
                                    maxValue: 2008,
                                    onChanged: (newValue) => setState(() =>
                                        _currentPickerYearValue = newValue)),
                              ),
                            ),
                          ],
                        ),
        ],
      ),
    );
  }
}
