import 'package:aunty_rafiki/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _availableAppointments = [];
  Appointment _selectedAppointment;
  //setters
  bool _isSubmittingData = false;
  set selectAppointment(Appointment appointment) {
    _selectedAppointment = appointment;
    notifyListeners();
  }

  //getters
  Appointment get seletectedAppointment => _selectedAppointment;
  List<Appointment> get availableAppointments => _availableAppointments;

  Future<bool> createAppointment(
      {@required name,
      @required profession,
      @required date,
      @required time,
      @required syncToCalender,
      @required additionalNotes}) async {
    _isSubmittingData = true;
    notifyListeners();
    final _appointment = Appointment(
        name: name,
        profession: profession,
        date: date,
        time: time,
        syncToCalender: syncToCalender,
        additionalNotes: additionalNotes);

    _availableAppointments.add(_appointment);
    _isSubmittingData = false;
    notifyListeners();
    return _isSubmittingData;
  }

  deletedAppoint(int index) {
    _availableAppointments.removeAt(index);
    notifyListeners();
  }
}
