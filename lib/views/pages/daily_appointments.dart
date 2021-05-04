import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/appointment_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appointment_details_page.dart';

class DailyAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text(Languages.of(context).labelAppointments, style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
          itemCount: _appointmentProvider.selectedCalendarAppointments.length,
          itemBuilder: (_, index) {
            return AppointmentTile(
              appointment:
                  _appointmentProvider.selectedCalendarAppointments[index],
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AppointmentDetailsPage(
                            appointment: _appointmentProvider
                                .availableAppointments[index])));
              },
            );
          }),
    );
  }
}
