import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/views/components/cards/calender_card.dart';
import 'package:aunty_rafiki/views/components/tiles/appointment_tile.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool _calenderView = true;

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          IconButton(
              tooltip: _calenderView ? 'List view' : 'Calendar view',
              onPressed: () {
                setState(() {
                  _calenderView = !_calenderView;
                });
              },
              icon:
                  Icon(_calenderView ? Icons.view_list : Icons.calendar_today))
        ],
      ),
      body: _calenderView
          ? SingleChildScrollView(
              child: Column(
              children: [
                CalenderCard(),
                SizedBox(height: 100),
                _appointmentProvider.availableAppointments.isEmpty
                    ? NoItemTile(
                        icon: 'assets/icons/calender.png',
                        title: 'No appointments to display',
                        subtitle: '',
                      )
                    : AppointmentTile(
                        appointment:
                            _appointmentProvider.availableAppointments.last)
              ],
            ))
          : _appointmentProvider.availableAppointments.isEmpty
              ? Center(
                  child: NoItemTile(
                    icon: 'assets/icons/calender.png',
                    title: 'No appointments to display',
                    subtitle: '',
                  ),
                )
              : ListView.builder(
                  itemCount: _appointmentProvider.availableAppointments.length,
                  itemBuilder: (_, index) {
                    return AppointmentTile(
                      appointment:
                          _appointmentProvider.availableAppointments[index],
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
                  Expanded(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, addAppointmentPage);
                      },
                      child: Text('ADD'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
