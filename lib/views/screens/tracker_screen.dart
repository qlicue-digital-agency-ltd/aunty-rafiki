import 'package:aunty_rafiki/providers/tracker_provider.dart';
import 'package:aunty_rafiki/views/pages/tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components/cards/tracker_card.dart';

class TrackerScreen extends StatelessWidget {
  // default color
  static Color _defaultColor = Colors.grey[300];

  // line style
  final LineStyle _lineStyle = LineStyle(color: _defaultColor, thickness: 2);

  // indicator style
  IndicatorStyle indicatorStyle(BuildContext context) {
    return IndicatorStyle(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      // iconStyle: IconStyle(
      //   iconData: Icons.add_circle_outline,
      //   fontSize: 16.0,
      //   color: Colors.grey,
      // ),
      indicatorXY: 0.1,
    );
  }

  // action to be performed when the card is tapped
  void _handleCardTap(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TrackerPage(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _trackerProvider = Provider.of<TrackerProvider>(context);
    return ListView.builder(
      itemCount: _trackerProvider.trackers.length,
      itemBuilder: (BuildContext context, int index) {
        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.05,
          isFirst: index == 0 ? true : false,
          isLast: index == _trackerProvider.trackers.length - 1 ? true : false,
          endChild: InkWell(
            onTap: () {
              _handleCardTap(context, index);
            },
            child: TrackerCard(
              tracker: _trackerProvider.trackers[index],
              index: index,
            ),
          ),
          afterLineStyle: _lineStyle,
          beforeLineStyle: _lineStyle,
          indicatorStyle: indicatorStyle(context),
        );
      },
    );
  }
}
