import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/picker/custom_number_picker.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CustomNumberPicker(
          title: 'How many weeks pregnant are you?',
          currentValue: _weeksOfPregnancy,
          onChanged: (value) {
            setState(() {
              _weeksOfPregnancy = value;
            });
          },
          miniValue: 4,
          maxValue: 43,
        ),
        Spacer(),
        SlideTransition(
            position: _animation,
            transformHitTests: true,
            child: CustomRaisedButton(
                title: 'Next',
                onPressed: () {
                  widget._changePage(widget._currentPage + 1);
                })),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
