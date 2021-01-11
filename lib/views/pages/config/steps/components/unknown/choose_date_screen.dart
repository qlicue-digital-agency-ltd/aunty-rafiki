import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';

import 'package:aunty_rafiki/views/components/cards/calendar_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseDateScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  const ChooseDateScreen({
    Key key,
    @required int currentPage,
    @required Function changePage,
  })  : _currentPage = currentPage,
        _changePage = changePage,
        super(key: key);

  @override
  _ChooseDateScreenState createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

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
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            _utilityProvider.titleCalender,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        CalendarCard(),
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
