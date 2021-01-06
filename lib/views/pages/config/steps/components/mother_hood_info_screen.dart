import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text('Motherhood Info'),
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
