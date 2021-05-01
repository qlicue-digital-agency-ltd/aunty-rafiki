import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_raised_button.dart';
import 'package:aunty_rafiki/views/components/buttons/custom_string_dropdown.dart';
import 'package:aunty_rafiki/views/components/buttons/number_counter.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreInfoScreen extends StatefulWidget {


  const MoreInfoScreen(
      {Key key,
      @required int currentPage,
      @required Function changePage,
      @required GlobalKey<ScaffoldState> scaffoldKey})
     :
        super(key: key);
  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  int _haemoglobinLevel = 12;
  String _clinic = "NO";
  String _medication = "NO";
  String _tetanasiVaccination = "NO";
  int _tetanasiVaccineNumber = 1;
  DateTime _nextTetanusDate;
  DateTime _lastTetanusDate;
  DateTime _haemoglobinLevelDate;

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    final _configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        NumberCounter(
          counter: _haemoglobinLevel,
          onTap: (val) {
            setState(() {
              if (val != null) _haemoglobinLevel += val;
            });
          },
          title: 'Haemoglobin Level',
          context: context,
        ),
        SizedBox(
          height: 15,
        ),
        Text('Last Time you checked Haemoglobin Level'),
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 240, 240, 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  dateMask: 'd MMM, yyyy',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    setState(() {
                      if (val != null)
                        _haemoglobinLevelDate = DateTime.parse(val);
                    });
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
              Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
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
              if (value != null) _clinic = value;
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
              if (value != null) _medication = value;
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
              if (value != null) _tetanasiVaccination = value;
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
                    if (val != null) _tetanasiVaccineNumber += val;
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 240, 240, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: DateTimePicker(
                            initialValue: '',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Date',
                            dateMask: 'd MMM, yyyy',
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              setState(() {
                                if (val != null)
                                  _lastTetanusDate = DateTime.parse(val);
                              });
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 240, 240, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: DateTimePicker(
                            initialValue: '',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Date',
                            dateMask: 'd MMM, yyyy',
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              setState(() {
                                if (val != null)
                                  _nextTetanusDate = DateTime.parse(val);
                              });
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
        CustomRaisedButton(
          title: 'Next',
          onPressed: () {
            setState(() {
              _isPressed = true;
            });
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
              setState(() {
                _isPressed = false;
              });
              if (!value) {
                //send data to af server...

                _configProvider.setConfigurationStep = Configuration.Done;
                _bloodLevelProvider.postBloodLevel(
                  quantity: _haemoglobinLevel.toDouble(),
                  date: _haemoglobinLevelDate.toString(),
                );

                Navigator.pushNamed(context, landingPage);
              }
            });
          },
          isPressed: _isPressed,
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
