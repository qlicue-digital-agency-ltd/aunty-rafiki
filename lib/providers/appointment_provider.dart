import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AppointmentProvider with ChangeNotifier {
  AppointmentProvider() {
    _calendarAppointments = {};

    _selectedCalendarAppointments =
        _calendarAppointments[_selectedCalendarDay] ?? [];
    fetchAppointments();
  }

  //variables
  bool _isFetchingAppointmentData = false;
  DateTime _selectedCalendarDay = DateTime.now();

  Map<DateTime, List> _calendarAppointments;
  List<Appointment> _availableAppointments = [];
  List _selectedCalendarAppointments = [];
  Appointment _selectedAppointment;

  //setters
  bool _isSubmittingData = false;
  set selectAppointment(Appointment appointment) {
    _selectedAppointment = appointment;
    notifyListeners();
  }

  set setCalendarDate(DateTime dateTime) {
    _selectedCalendarDay = dateTime;
    notifyListeners();
  }

  set selectCalendarAppointments(List appoinments) {
    _selectedCalendarAppointments = appoinments;
    notifyListeners();
  }

  //getters
  Appointment get seletectedAppointment => _selectedAppointment;
  List<Appointment> get availableAppointments => _availableAppointments;

  List get selectedCalendarAppointments => _selectedCalendarAppointments;
  Map<DateTime, List> get calendarAppointments => _calendarAppointments;
  DateTime get selectedCalendarDay => _selectedCalendarDay;
  bool get isFetchingAppointmentData => _isFetchingAppointmentData;
  bool get isSubmittingData => _isSubmittingData;

  //fetch Appointments...
  Future<bool> fetchAppointments() async {
    bool hasError = true;
    _isFetchingAppointmentData = true;
    notifyListeners();
    final Map<String, dynamic> _data = {
      "uid": FirebaseAuth.instance.currentUser.uid
    };

    final List<Appointment> _fetchedAppointments = [];
    try {
      final http.Response response = await http.post(Uri.parse(api + "appointments"),
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['data'].forEach((appointmentData) {
          final _appointment = Appointment.fromMap(appointmentData);
          _fetchedAppointments.add(_appointment);
        });
        hasError = false;
      }

      print(_fetchedAppointments);
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableAppointments = _fetchedAppointments;
    _isFetchingAppointmentData = false;

    _availableAppointments.forEach((appointment) {
      _updateCalenderAppointments(appointment.date);
    });
    notifyListeners();

    return hasError;
  }

  //post appointment
  Future<bool> createAppointment(
      {@required name,
      @required profession,
      @required date,
      @required time,
      @required syncToCalendar,
      @required additionalNotes}) async {
    bool hasError = true;
    _isSubmittingData = true;

    notifyListeners();
    final Map<String, dynamic> _data = {
      "name": name,
      "profession": profession,
      "sync_to_calendar": syncToCalendar,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
      "time": "00:00:00",
      "uid": FirebaseAuth.instance.currentUser.uid,
      "additional_notes": additionalNotes
    };
    final http.Response response = await http.post(Uri.parse(api + "appointment"),
        body: json.encode(_data),
        headers: {'Content-Type': 'application/json'});
    print(response.body);

    try {
      final http.Response response = await http.post(Uri.parse(api + "appointment"),
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final _appointment = Appointment.fromMap(data['data']);
        _availableAppointments.add(_appointment);

        _selectedCalendarAppointments.add(_appointment);
        _updateCalenderAppointments(date);
        hasError = false;
      }
    } catch (error) {
      hasError = true;
    }
    _isSubmittingData = false;
    notifyListeners();
    return hasError;
  }

  //update appointment
  _updateCalenderAppointments(date) {
    final DateFormat _formatter = DateFormat('yyyy-MM-dd');

    _calendarAppointments[DateTime.parse(date)] = _availableAppointments
        .where((appointment) =>
            _formatter.format(DateTime.parse(appointment.date)) ==
            _formatter.format(DateTime.parse(date)))
        .toList();
    notifyListeners();
  }

  deletedAppoint(int index) {
    _availableAppointments.removeAt(index);
    notifyListeners();
  }
}
