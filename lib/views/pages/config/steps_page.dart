import 'dart:io';

import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/components/steps/step_progress_view.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/more_info_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/mother_hood_info_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/name_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/unknown/choose_date_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/unknown/determine_week_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/weeks_pregnancy_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/year_of_birth_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepsPage extends StatefulWidget {
  @override
  _StepsPageState createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Colors.pink;

  Color _inactiveColor = Colors.grey;
  String _title = "Mother's Name";

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  int _currentPregPage = 1;
  int _currentUnknownPregPage = 1;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  PageController _pageUnknownController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);

    List<Widget> _screens = [
      NameScreen(
        currentPage: 0,
        changePage: _changePage,
      ),
      WeeksPregnancyScreen(
        currentPage: 1,
        changePage: _changePage,
      ),
      YearOfBirthScreen(
        currentPage: 2,
        changePage: _changePage,
      ),
      MotherhoodInfoScreen(
        currentPage: 3,
        changePage: _changePage,
      ),
      MoreInfoScreen(
        currentPage: 4,
        changePage: _changePage,
        scaffoldKey: _scafoldKey,
      ),
    ];
    List<Widget> _unknownScreens = [
      DetermineWeekScreen(
        currentPage: 0,
        changePage: _changeUnknownPregnancyPage,
      ),
      ChooseDateScreen(
        currentPage: 1,
        changePage: _changeUnknownPregnancyPage,
      ),
    ];
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon:
                Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            onPressed: () {
              if (_utilityProvider.knownPregnancy) {
                if (_currentPregPage == 2) {
                  _changePage(0);
                } else if (_currentPregPage == 3) {
                  _changePage(1);
                } else if (_currentPregPage == 4) {
                  _changePage(2);
                } else if (_currentPregPage == 5) {
                  _changePage(3);
                } else {
                  Navigator.pop(context);
                }
              } else {
                if (_currentUnknownPregPage == 2) {
                  _changeUnknownPregnancyPage(0);
                } else {
                  Navigator.pop(context);
                }
              }
            }),
        title: Text('Profile'),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _utilityProvider.knownPregnancy
                  ? StepProgressView(
                      steps: _screens.length,
                      curStep: _currentPregPage,
                      height: _stepProgressViewHeight,
                      width: MediaQuery.of(context).size.width,
                      dotRadius: _stepCircleRadius,
                      activeColor: _activeColor,
                      inactiveColor: _inactiveColor,
                      headerStyle: _headerStyle,
                      stepsStyle: _stepStyle,
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.only(
                        top: 48.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      title: _title,
                    )
                  : StepProgressView(
                      steps: _unknownScreens.length,
                      curStep: 1,
                      height: _stepProgressViewHeight,
                      width: MediaQuery.of(context).size.width,
                      dotRadius: _stepCircleRadius,
                      activeColor: _activeColor,
                      inactiveColor: _inactiveColor,
                      headerStyle: _headerStyle,
                      stepsStyle: _stepStyle,
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.only(
                        top: 48.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      title: _title,
                    ),
              Expanded(
                child: _utilityProvider.knownPregnancy
                    ? PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: _screens,
                      )
                    : PageView(
                        controller: _pageUnknownController,
                        physics: NeverScrollableScrollPhysics(),
                        children: _unknownScreens,
                      ),
              )
            ],
          )),
    );
  }

  void _changePage(int index) {
    // or this to jump to it without animating

    _pageController.jumpToPage(index);
    setState(() {
      _currentPregPage = index + 1;
      if (index == 0) {
        _title = "Mother's Name";
      }
      if (index == 1) {
        _title = "Weeks of Pregnancy";
      }
      if (index == 2) {
        _title = "Mother's Birthday";
      }
      if (index == 3) {
        _title = "Motherhood Information";
      }
      if (index == 4) {
        _title = "More Information";
      }
    });
  }

  void _changeUnknownPregnancyPage(int index) {
    _pageUnknownController.jumpToPage(index);
    setState(() {
      _currentUnknownPregPage = index + 1;
      if (index == 0) {
        _title = "Detect your week";
      }
      if (index == 1) {
        _title = "Calender";
      }
    });
  }
}
