import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_date_picker_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_string_dropdown.dart';
import 'package:aunty_rafiki/views/components/buttons/number_counter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreInfoScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const MoreInfoScreen(
      {Key key,
      @required int currentPage,
      @required Function changePage,
      @required GlobalKey<ScaffoldState> scaffoldKey})
      : _scaffoldKey = scaffoldKey,
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
    final _authProvider = Provider.of<AuthProvider>(context);
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
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
                  _authProvider
                      .updateAdditionalInfo(
                          haemoLevel: _haemoglobinLevel,
                          haemoLevelDate: _haemoglobinLevelDate,
                          lastDateTetanusVaccine: _lastTetanusDate,
                          nextDateTetanusVaccine: _nextTetanusDate,
                          onMedication: _medication,
                          startedClinic: _clinic,
                          takenTetanusVaccine: _tetanasiVaccination)
                      .then((value) {
                    if (!value) {
                      //send data to af server...

                      _bloodLevelProvider.postBloodLevel(
                        quantity: _haemoglobinLevel.toDouble(),
                        date: _haemoglobinLevelDate,
                      );

                      _authProvider.setConfigurationStep = Configuration.Done;
                      Navigator.pushNamed(context, landingPage);
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
