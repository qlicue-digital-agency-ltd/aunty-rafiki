import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/views/components/cards/calendar_card.dart';
import 'package:aunty_rafiki/views/components/tiles/appointment_tile.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:aunty_rafiki/views/pages/appointment_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool _calendarView = true;

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          IconButton(
              tooltip: _calendarView ? 'List view' : 'Calendar view',
              onPressed: () {
                setState(() {
                  _calendarView = !_calendarView;
                });
              },
              icon:
                  Icon(_calendarView ? Icons.view_list : Icons.calendar_today))
        ],
      ),
      body: _calendarView
          ? SingleChildScrollView(
              child: Column(
              children: [
                CalendarCard(),
                SizedBox(height: 100),
                _appointmentProvider.selectedCalendarAppointments.isEmpty
                    ? NoItemTile(
                        icon: 'assets/icons/calendar.png',
                        title: 'No appointments to display',
                      )
                    : Column(
                        // mainAxisAlignment: MainAxisAlignment.,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text('Recent'),
                          ),
                          AppointmentTile(
                            appointment: _appointmentProvider
                                .selectedCalendarAppointments.last,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AppointmentDetailsPage(
                                          appointment: _appointmentProvider
                                              .availableAppointments.last)));
                            },
                          ),
                          _appointmentProvider
                                      .selectedCalendarAppointments.length >
                                  1
                              ? TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, dailyAppointmentsPage);
                                  },
                                  child: Text('View All'))
                              : Container()
                        ],
                      )
              ],
            ))
          : _appointmentProvider.availableAppointments.isEmpty
              ? Center(
                  child: NoItemTile(
                    icon: 'assets/icons/calendar.png',
                    title: 'No appointments to display',
                  ),
                )
              : ListView.builder(
                  itemCount: _appointmentProvider.availableAppointments.length,
                  itemBuilder: (_, index) {
                    return AppointmentTile(
                      appointment:
                          _appointmentProvider.availableAppointments[index],
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
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 80,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ///Button for add new task
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10)),
                        // padding: const EdgeInsets.symmetric(vertical: 16),
                        // color: Colors.pink[400],
                        child: Text(
                          "ADD APPOINTMENT",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, addAppointmentPage);
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
