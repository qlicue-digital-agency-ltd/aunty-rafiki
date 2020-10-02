import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/appointment_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Appointments'),
      ),
      body: ListView.builder(
          itemCount: _appointmentProvider.selectedCalendarAppointments.length,
          itemBuilder: (_, index) {
            return AppointmentTile(
              appointment:
                  _appointmentProvider.selectedCalendarAppointments[index],
            );
          }),
    );
  }
}
