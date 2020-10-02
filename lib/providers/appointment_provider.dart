import 'package:aunty_rafiki/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  AppointmentProvider() {
    _calendarAppointments = {};

    _selectedCalendarAppointments =
        _calendarAppointments[_selectedCalendarDay] ?? [];
  }
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
  Future<bool> createAppointment(
      {@required name,
      @required profession,
      @required date,
      @required time,
      @required syncToCalendar,
      @required additionalNotes}) async {
    _isSubmittingData = true;
    notifyListeners();
    final _appointment = Appointment(
        name: name,
        profession: profession,
        date: date,
        time: time,
        syncToCalendar: syncToCalendar,
        additionalNotes: additionalNotes);

    _availableAppointments.add(_appointment);
    _selectedCalendarAppointments.add(_appointment);
    _calendarAppointments[DateTime.parse(date)] = _availableAppointments
        .where((appointment) =>
            DateTime.parse(appointment.date) == DateTime.parse(date))
        .toList();

    _isSubmittingData = false;
    notifyListeners();
    return _isSubmittingData;
  }

  deletedAppoint(int index) {
    _availableAppointments.removeAt(index);
    notifyListeners();
  }
}
