import 'package:aunty_rafiki/views/components/buttons/custom_date_picker_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_string_dropdown.dart';
import 'package:aunty_rafiki/views/components/buttons/number_counter.dart';

import 'package:flutter/material.dart';

class MoreInfoScreen extends StatefulWidget {
  final int _currentPage;
  final Function(int) _changePage;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  const MoreInfoScreen(
      {Key key,
      @required int currentPage,
      @required Function changePage,
      @required GlobalKey<ScaffoldState> scaffoldKey})
      : _currentPage = currentPage,
        _changePage = changePage,
        _scaffoldKey = scaffoldKey,
        super(key: key);
  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int _haemoglobinLevel = 12;
  String _clinic = "NO";
  String _medication = "NO";
  String _tetanasiVaccination = "NO";
  int _tetanasiVaccineNumber = 1;
  DateTime _nextTetanusDate;
  DateTime _lastTetanusDate;
  DateTime _haemoglobinLevelDate;

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
          counter: _haemoglobinLevel,
          onTap: (val) {
            setState(() {
              _haemoglobinLevel = val;
            });
          },
          title: 'Haemoglobin Level',
          context: context,
        ),
        SizedBox(
          height: 15,
        ),
        Text('Last Time you checked Haemoglobin Level'),
        CustomDatePickerButton(
          title: 'Date',
          scaffoldKey: widget._scaffoldKey,
          isRequired: true,
          maximumYear: 2022,
          minimumYear: 1902,
          selectedDate: _haemoglobinLevelDate,
          onChange: (dateTime) {
            setState(() {
              _haemoglobinLevelDate = dateTime;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        CustomStringDropdown(
          title: 'Have you started Clinic?',
          value: _clinic,
          items: ["NO", "YES"],
          onChange: (value) {
            setState(() {
              _clinic = value;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        CustomStringDropdown(
          title: 'Are you using any medication?',
          value: _medication,
          items: ["NO", "YES"],
          onChange: (value) {
            setState(() {
              _medication = value;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        CustomStringDropdown(
          title: 'Have you taken a Tetanasi vaccination?',
          value: _tetanasiVaccination,
          items: ["NO", "YES"],
          onChange: (value) {
            setState(() {
              _tetanasiVaccination = value;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        _tetanasiVaccination == "YES"
            ? NumberCounter(
                counter: _tetanasiVaccineNumber,
                onTap: (val) {
                  setState(() {
                    _tetanasiVaccineNumber = val;
                  });
                },
                title: 'How many times have you had the Tetanasi vaccincation?',
                context: context,
              )
            : Container(),
        SizedBox(
          height: 15,
        ),
        _tetanasiVaccination == "YES"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last Time you had the Tetanasi vaccincation'),
                  CustomDatePickerButton(
                    title: 'Date',
                    scaffoldKey: widget._scaffoldKey,
                    isRequired: true,
                    maximumYear: 2022,
                    minimumYear: 1902,
                    selectedDate: _lastTetanusDate,
                    onChange: (dateTime) {
                      setState(() {
                        _lastTetanusDate = dateTime;
                      });
                    },
                  ),
                ],
              )
            : Container(),
        SizedBox(
          height: 15,
        ),
        _tetanasiVaccination == "YES"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('When is your next Tetanasi vaccincation'),
                  CustomDatePickerButton(
                    title: 'Date',
                    scaffoldKey: widget._scaffoldKey,
                    isRequired: true,
                    maximumYear: 2022,
                    minimumYear: 1902,
                    selectedDate: _nextTetanusDate,
                    onChange: (dateTime) {
                      setState(() {
                        _nextTetanusDate = dateTime;
                      });
                    },
                  ),
                ],
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
