import 'dart:async';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_date_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:connectivity/connectivity.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddBloodLevelPage extends StatefulWidget {
  @override
  _AddBloodLevelPageState createState() => _AddBloodLevelPageState();
}

class _AddBloodLevelPageState extends State<AddBloodLevelPage> {
  String date = 'Date';

  String valueDate = '';
  String valueToValidate3 = '';
  String valueSaved3 = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _valueEditingController = TextEditingController();

  TextEditingController _dateEditingController;

  @override
  void initState() {
    _getValue();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _dateEditingController.text = '22-11-2020';
      });
    });
  }

  ///check for internet connection
  String _connectionStatus = 'unknown';

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'unknown');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    _dateEditingController = TextEditingController(
        text: _appointmentProvider.selectedCalendarDay.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(Languages.of(context).labelAddBloodLevel,
            style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              IconTextField(
                icon: Icons.local_hospital,
                textEditingController: _valueEditingController,
                textInputType: TextInputType.number,
                title: Languages.of(context).labelBloodLevelTitle,
                suffix: 'g/dl',
                validator: (val) {
                  if (val.isEmpty)
                    return Languages.of(context).labelEnterBloodLevel;
                  else
                    return null;
                },
              ),
              IconDateField(
                onChage: (val) {},
                onSaved: (val) {},
                onValidate: (val) {
                  setState(() => valueToValidate3 = val);
                  return null;
                },
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                textEditingController: _dateEditingController,
                icon: Icons.calendar_today,
                title: 'Date',
                dateMask: "EEEE, MMMM d, y",
                type: DateTimePickerType.date,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _bloodLevelProvider.isSubmittingData
                            ? Loading()
                            : Text(
                                Languages.of(context)
                                    .labelSaveButton
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                        onPressed: () {
                          if (_connectionStatus == 'ConnectivityResult.none' ||
                              _connectionStatus == 'unknown') {
                            Fluttertoast.showToast(
                                msg: Languages.of(context)
                                    .labelNoItemTileInternet,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            if (!_bloodLevelProvider.isSubmittingData) if (_formKey
                                .currentState
                                .validate()) {
                              _bloodLevelProvider
                                  .postBloodLevel(
                                quantity:
                                    double.parse(_valueEditingController.text),
                                date: _dateEditingController.text,
                              )
                                  .then((value) {
                                if (!value) {
                                  Navigator.pop(context);
                                } else {}
                              });
                            } else {}
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
