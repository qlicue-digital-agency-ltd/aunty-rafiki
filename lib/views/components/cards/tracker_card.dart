import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/tracker.dart';

class TrackerCard extends StatelessWidget {
  final Tracker tracker;
  final Function onTap;

  TrackerCard({@required this.tracker, @required this.onTap});

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
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('DAY ${tracker.days}'),
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
                      title: Text(
                        tracker.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        tracker.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        child: Loading(),
                        padding: EdgeInsets.all(70.0),
                        decoration: BoxDecoration(
                          color: greyColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Material(
                        child: Image.asset(
                          'assets/images/img_not_available.jpeg',
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      ),
                      imageUrl: tracker.media,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 14.0),
                      child: Text(
                        tracker.body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
