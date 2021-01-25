import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
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

class _WeeksPregnancyScreenState extends State<WeeksPregnancyScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<Offset> _animation;
  int _weeksOfPregnancy = 4;
  bool _isSelected = false;

  void itemChange(bool val) {
    setState(() {
      _isSelected = val;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
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
        Spacer(),
        SlideTransition(
            position: _animation,
            transformHitTests: true,
            child: Column(
              children: [
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
                      if (_isSelected) {
                        _utilityProvider.setKnownPregnancy = false;

                        widget._changePage(widget._currentPage + 1);
                      } else {
                        _authProvider
                            .updatePregnancyWeeks(
                                pregnancyWeeks: _weeksOfPregnancy)
                            .then((value) {
                          if (!value) {
                            widget._changePage(widget._currentPage + 1);
                          }
                        });
                      }
                    }),
              ],
            )),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
