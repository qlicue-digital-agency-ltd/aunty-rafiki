import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderCard extends StatefulWidget {
  @override
  _CalenderCardState createState() => _CalenderCardState();
}

class _CalenderCardState extends State<CalenderCard> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
    calendarController: _calendarController,
  );
  }
}
