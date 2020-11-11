import 'package:aunty_rafiki/models/tracker.dart';
import 'package:aunty_rafiki/providers/tracker_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/tracker_tile.dart';
import 'package:aunty_rafiki/views/pages/tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../components/cards/tracker_card.dart';

class TrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _trackerProvider = Provider.of<TrackerProvider>(context);
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _trackerProvider.availableTrackers.length,
      itemBuilder: (BuildContext context, int index) {
        final Tracker tracker = _trackerProvider.availableTrackers[index];

        final IndicatorStyle indicator = tracker.isCheckpoint
            ? _indicatorStyleCheckpoint(tracker)
            : const IndicatorStyle(width: 0);

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.15,
          isFirst: index == 0,
          isLast: index == _trackerProvider.availableTrackers.length - 1,
          startChild: _LeftChildTimeline(
            tracker: _trackerProvider.availableTrackers[index],
          ),
          endChild: _RightChildTimeline(
            tracker: _trackerProvider.availableTrackers[index],
          ),
          indicatorStyle: indicator,
          hasIndicator: _trackerProvider.availableTrackers[index].isCheckpoint,
          beforeLineStyle: LineStyle(
            color: tracker.color,
            thickness: 8,
          ),
        );
      },
    );
  }

  IndicatorStyle _indicatorStyleCheckpoint(Tracker tracker) {
    return IndicatorStyle(
      width: 46,
      height: 100,
      indicator: Container(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Week',
                textAlign: TextAlign.center,
                style: GoogleFonts.patrickHand(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Stack(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 35,
                  ),
                  Positioned(
                    left: tracker.week > 9 ? 8 : 12,
                    top: 6,
                    child: Text(
                      tracker.week.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftChildTimeline extends StatelessWidget {
  const _LeftChildTimeline({Key key, this.tracker}) : super(key: key);

  final Tracker tracker;

  @override
  Widget build(BuildContext context) {
    return tracker.isCheckpoint
        ? Container()
        : tracker.show
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(right: tracker.isCheckpoint ? 5 : 5),
                    child: Text(
                      tracker.day,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  )
                ],
              )
            : Container();
  }
}

class _RightChildTimeline extends StatelessWidget {
  final Tracker tracker;

  const _RightChildTimeline({Key key, @required this.tracker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _trackerProvider = Provider.of<TrackerProvider>(context);
    return tracker.isCheckpoint
        ? TrackerTile(
            tracker: tracker,
            onTap: () {
              _trackerProvider.toogleTracker = tracker.week;
            },
          )
        : tracker.show
            ? TrackerCard(
                tracker: tracker,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TrackerPage(
                          tracker: tracker,
                        );
                      },
                    ),
                  );
                },
              )
            : Container();
  }
}
