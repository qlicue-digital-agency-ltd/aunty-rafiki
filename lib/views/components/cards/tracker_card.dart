import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/tracker.dart';

class TrackerCard extends StatelessWidget {
  final Tracker tracker;

  TrackerCard({@required this.tracker});

  // date format instance
  final DateFormat format = DateFormat("EEEE, MMMM d, y");

  // mock registration date
  final DateTime _registrationDate = DateTime.parse("2020-01-01");

  // calculate number of weeks since registration
  int numberOfWeeks(DateTime dateTime) {
    final date = dateTime;
    final firstMonday = _registrationDate.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = date.difference(_registrationDate);
    int weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();

    if (daysInFirstWeek > 3) {
      weeks += 1;
    }

    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    // formatted date e.g. Friday, April 28, 2017
    // final date = format.format(tracker.time);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('${numberOfWeeks(tracker.time)} WEEKS'),
            subtitle: Text('${format.format(tracker.time)}'.toUpperCase()),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(tracker.headText),
                    subtitle: Text(tracker.subheadText),
                  ),
                  Image.asset(tracker.media),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 14.0),
                    child: Text(
                      tracker.supportText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
