import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../models/tracker.dart';
import '../widgets/cards/tracker_card.dart';

class TrackerScreen extends StatelessWidget {
  // default color
  static Color _defaultColor = Colors.grey[300];

  // line style
  final LineStyle _lineStyle = LineStyle(color: _defaultColor, thickness: 2);

  // indicator style
  final IndicatorStyle _indicatorStyle = IndicatorStyle(
    color: _defaultColor,
    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
    // iconStyle: IconStyle(
    //   iconData: Icons.add_circle_outline,
    //   fontSize: 16.0,
    //   color: Colors.grey,
    // ),
    indicatorXY: 0.05,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trackers.length,
      itemBuilder: (BuildContext context, int index) {
        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.05,
          isFirst: index == 0 ? true : false,
          isLast: index == trackers.length - 1 ? true : false,
          endChild: TrackerCard(tracker: trackers[index]),
          afterLineStyle: _lineStyle,
          beforeLineStyle: _lineStyle,
          indicatorStyle: _indicatorStyle,
        );
      },
    );
  }
}
