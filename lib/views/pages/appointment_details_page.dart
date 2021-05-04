import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final Appointment appointment;

  AppointmentDetailsPage({Key key, @required this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text(Languages.of(context).labelAppointments, style: TextStyle(color: Colors.black)),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            ///Container for Icon
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(255, 240, 240, 1)),
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.redAccent,
                              ),
                            ),

                            ///For spacing
                            SizedBox(
                              width: 24,
                            ),
                            Expanded(child: Text(widget.appointment.name)),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            ///Container for Icon
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(255, 240, 240, 1)),
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.redAccent,
                              ),
                            ),

                            ///For spacing
                            SizedBox(
                              width: 24,
                            ),
                            Expanded(child: Text(widget.appointment.date)),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            ///Container for Icon
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(255, 240, 240, 1)),
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                Icons.lock_clock,
                                color: Colors.redAccent,
                              ),
                            ),

                            ///For spacing
                            SizedBox(
                              width: 24,
                            ),
                            Expanded(child: Text(widget.appointment.time)),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            ///Container for Icon
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(255, 240, 240, 1)),
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                Icons.person,
                                color: Colors.redAccent,
                              ),
                            ),

                            ///For spacing
                            SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Text(widget.appointment.profession)),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Text(
                        'Notes:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        widget.appointment.additionalNotes == null
                            ? ''
                            : widget.appointment.additionalNotes.toString(),
                        maxLines: 10,
                      ),
                    ],
                  ),

                  ///
                  SizedBox(height: 30),
                ],
              ),
            )),
          )
        ]),
      ),
    );
  }
}
