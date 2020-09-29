import 'package:aunty_rafiki/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;

  const AppointmentTile({Key key, @required this.appointment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        ListTile(
          leading: CircleAvatar(
            radius: 40,
            child: Center(child: Image.asset('assets/icons/time.png')),
          ),
          title: Text((appointment.date) +
              '\t' +
              appointment.name),
          subtitle: Text(appointment.time + ', with ' + appointment.profession),
        ),
        Divider()
      ]),
    );
  }
}
