import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/picker/custom_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearOfBirthScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const YearOfBirthScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);

  @override
  _YearOfBirthScreenState createState() => _YearOfBirthScreenState();
}

class _YearOfBirthScreenState extends State<YearOfBirthScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<Offset> _animation;

  int _yearOfBirth = 1988;

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
    final _authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CustomNumberPicker(
          title: 'What year were you born?',
          subtitle:
              'Telling us your age will help us give us precise information',
          currentValue: _yearOfBirth,
          onChanged: (value) {
            setState(() {
              _yearOfBirth = value;
            });
          },
          miniValue: 1931,
          maxValue: 2008,
        ),
        Spacer(),
        SlideTransition(
            position: _animation,
            transformHitTests: true,
            child: CustomRaisedButton(
                title: 'Next',
                onPressed: () {
                  _authProvider
                      .updateYearOfBirth(yearOfBirth: _yearOfBirth)
                      .then((value) {
                    if (!value) {
                      widget._changePage(widget._currentPage + 1);
                    }
                  });
                })),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
