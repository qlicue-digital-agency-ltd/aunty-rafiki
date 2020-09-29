import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/views/components/cards/calender_card.dart';
import 'package:aunty_rafiki/views/components/tiles/appointment_tile.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool _calenderView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          FlatButton(
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _calenderView = !_calenderView;
                });
              },
              child: Text(_calenderView ? 'List View' : 'Calender View'))
        ],
      ),
      body: _calenderView
          ? SingleChildScrollView(
              child: Column(
              children: [
                CalenderCard(),
                SizedBox(height: 100),
                NoItemTile(
                  icon: 'assets/icons/calender.png',
                  title: 'No appointments to display',
                  subtitle: '',
                )
              ],
            ))
          : ListView.builder(itemBuilder: (_, index) {
              return AppointmentTile();
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
