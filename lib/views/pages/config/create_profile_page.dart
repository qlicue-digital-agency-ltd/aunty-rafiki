import 'package:aunty_rafiki/views/components/steps/step_progress_view.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/mother_hood_info_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/name_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/weeks_pregnancy_screen.dart';

import 'package:flutter/material.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _steps = 4;

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Colors.pink;

  Color _inactiveColor = Colors.grey;
  String _title = "Mother's Name";

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  int _currentPage = 1;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150.0,
                child: StepProgressView(
                  steps: _steps,
                  curStep: _currentPage,
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
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    NameScreen(
                      currentPage: 0,
                      changePage: _changePage,
                    ),

                    WeeksPregnancyScreen(
                      currentPage: 1,
                      changePage: _changePage,
                    ),
                    MotherhoodInfoScreen(
                      currentPage: 2,
                      changePage: _changePage,
                    ),
                    NameScreen(
                      currentPage: 2,
                      changePage: _changePage,
                    ),

                    // Container(
                    //   color: Colors.pink,
                    // ),
                  ],
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
      _currentPage = index + 1;
      if (index == 0) {
        _title = "Mother's Name";
      }
      if (index == 1) {
        _title = "Weeks of Pregnancy";
      }
      if (index == 2) {
        _title = "Motherhood Information";
      }
      if (index == 3) {
        _title = "More Information";
      }
    });
  }
}
