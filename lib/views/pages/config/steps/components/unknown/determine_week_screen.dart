import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/radio_label_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetermineWeekScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const DetermineWeekScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);

  @override
  _DetermineWeekScreenState createState() => _DetermineWeekScreenState();
}

class _DetermineWeekScreenState extends State<DetermineWeekScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<Offset> _animation;

  int _isRadioSelected = 1;

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
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
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
            _utilityProvider.setTitleCalender =
                'When did your last period start?';
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
            _utilityProvider.setTitleCalender = 'Select the expected due date';
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
            _utilityProvider.setTitleCalender = 'Select date of conception';
          },
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
