import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCard extends StatefulWidget {
  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  //CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

  //  _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
   // _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);

    void _onDaySelected(DateTime day, List events,List holiday) {
      print('CALLBACK: _onDaySelected');
      _appointmentProvider.setCalendarDate = day;
      _appointmentProvider.selectCalendarAppointments = events;
      //_selectedEvents = events;
    }

    return TableCalendar(
      // events: _appointmentProvider.calendarAppointments,
      // //holidays: _holidays,
      // calendarController: _calendarController,
      // calendarStyle: CalendarStyle(
      //   selectedColor: Theme.of(context).primaryColor,
      //   todayColor: Colors.pink[200],
      //   markersColor: Colors.brown[700],
      //   outsideDaysVisible: false,
      // ),
      // onDaySelected: _onDaySelected,
      // onVisibleDaysChanged: _onVisibleDaysChanged,
      // onCalendarCreated: _onCalendarCreated,
    );
  }
}
