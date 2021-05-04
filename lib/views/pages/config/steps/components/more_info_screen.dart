import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
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
      : super(key: key);
  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  int _haemoglobinLevel = 12;
  String _clinic = "";
  String _medication = "";
  String _tetanasiVaccination = "";
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

    List<String> _boolClinic = [
      Languages.of(context).labelYes,
      Languages.of(context).labelNo
    ];

    List<String> _boolMedication = [
      Languages.of(context).labelYes,
      Languages.of(context).labelNo
    ];

    List<String> _boolVaccination = [
      Languages.of(context).labelYes,
      Languages.of(context).labelNo
    ];

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        NumberCounter(
          counter: _haemoglobinLevel,
          onTap: (val) {
            setState(() {
              if (_haemoglobinLevel > 0) {
                if (val != null) _haemoglobinLevel += val;
              } else if (val > 0) {
                if (val != null) _haemoglobinLevel += val;
              }
            });
          },
          title: Languages.of(context).labelHaemoglobinLevel,
          context: context,
        ),
        SizedBox(
          height: 15,
        ),
        Text(Languages.of(context).labelLastCheckHaemoglobinLevel),
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
                  dateLabelText: Languages.of(context).labelDateTitle,
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
          title: Languages.of(context).labelStartedClinic,
          value: _boolClinic.contains(_clinic)
              ? _clinic
              : Languages.of(context).labelNo,
          items: _boolClinic.toList(),
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
          title: Languages.of(context).labelUsingMedication,
          value: _boolMedication.contains(_medication)
              ? _medication
              : Languages.of(context).labelNo,
          items: _boolMedication.toList(),
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
          title: Languages.of(context).labelTetanusVacination,
          value: _boolVaccination.contains(_tetanasiVaccination)
              ? _tetanasiVaccination
              : Languages.of(context).labelNo,
          items: _boolVaccination.toList(),
          onChange: (value) {
            setState(() {
              if (value != null) _tetanasiVaccination = value;
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        _tetanasiVaccination == Languages.of(context).labelYes
            ? NumberCounter(
                counter: _tetanasiVaccineNumber,
                onTap: (val) {
                  setState(() {
                    if (_tetanasiVaccineNumber > 0) {
                      if (val != null) _tetanasiVaccineNumber += val;
                    } else if (val > 0) {
                      if (val != null) _tetanasiVaccineNumber += val;
                    }
                  });
                },
                title: Languages.of(context).labelNumberTetanusVacination,
                context: context,
              )
            : Container(),
        SizedBox(
          height: 15,
        ),
        _tetanasiVaccination == Languages.of(context).labelYes
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Languages.of(context).labelDateLastTetanusVacination),
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
                            dateLabelText: Languages.of(context).labelDateTitle,
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
        _tetanasiVaccination == Languages.of(context).labelYes
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Languages.of(context).labelDateNextTetanusVacination),
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
                            dateLabelText: Languages.of(context).labelDateTitle,
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
          title: Languages.of(context).labelNextButton,
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
