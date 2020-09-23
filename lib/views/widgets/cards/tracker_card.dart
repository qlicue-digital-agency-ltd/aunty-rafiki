import 'package:flutter/material.dart';

import '../../../models/tracker.dart';

class TrackerCard extends StatelessWidget {
  final Tracker tracker;

  TrackerCard({@required this.tracker});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Card(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
                child: Text(
                  tracker.supportText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
