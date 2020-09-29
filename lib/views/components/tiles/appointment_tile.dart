import 'package:flutter/material.dart';

class AppointmentTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        ListTile(
          leading: CircleAvatar(
            radius: 40,
            child: Center(child: Image.asset('assets/icons/time.png')),
          ),
          title: Text('22 Sep, Name of the appointment'),
          subtitle: Text('12:22, with Doctor'),
        ),
        Divider()
      ]),
    );
  }
}
