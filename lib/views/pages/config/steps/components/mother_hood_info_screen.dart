import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_string_dropdown.dart';
import 'package:aunty_rafiki/views/components/buttons/number_counter.dart';

import 'package:flutter/material.dart';

class MotherhoodInfoScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const MotherhoodInfoScreen(
      {Key key, @required int currentPage, @required Function changePage})
      : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);
  @override
  _MotherhoodInfoScreenState createState() => _MotherhoodInfoScreenState();
}

class _MotherhoodInfoScreenState extends State<MotherhoodInfoScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int _gravida = 1;
  String _miscarriage = "NO";
  int _miscarriageAge = 1;
  int _births = 0;
  int _operationBirths = 0;
  int _normalBirths = 0;

  Animation<Offset> _animation;
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
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 10,
        ),
        NumberCounter(
          counter: _gravida,
          onTap: (val) {
            setState(() {
              _gravida = val;
            });
          },
          title: 'Gravida',
          context: context,
        ),
        SizedBox(
          height: 10,
        ),
        CustomStringDropdown(
          title: 'Ever had a miscarriage?',
          value: _miscarriage,
          items: ["NO", "YES"],
          onChange: (value) {
            setState(() {
              _miscarriage = value;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        _miscarriage == "YES"
            ? NumberCounter(
                counter: _miscarriageAge,
                onTap: (val) {
                  setState(() {
                    _miscarriageAge = val;
                  });
                },
                title: 'How many weeks was the pregnancy upon miscarriage?',
                context: context,
              )
            : Container(),
        _miscarriage == "YES"
            ? SizedBox(
                height: 10,
              )
            : Container(),
        NumberCounter(
          counter: _births,
          onTap: (val) {
            setState(() {
              _births = val;
            });
          },
          title: 'How many times have you given birth?',
          context: context,
        ),
        SizedBox(
          height: 10,
        ),
        _births > 0
            ? NumberCounter(
                counter: _operationBirths,
                onTap: (val) {
                  setState(() {
                    _operationBirths = val;
                  });
                },
                title: 'How many times did you give birth by operation?',
                context: context,
              )
            : Container(),
        _births > 0
            ? SizedBox(
                height: 10,
              )
            : Container(),
        _births > 0
            ? NumberCounter(
                counter: _normalBirths,
                onTap: (val) {
                  setState(() {
                    _normalBirths = val;
                  });
                },
                title: 'How many times did you give birth normally?',
                context: context,
              )
            : Container(),
        _births > 0
            ? SizedBox(
                height: 10,
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
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
