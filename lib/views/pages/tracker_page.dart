import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aunty_rafiki/providers/tracker_provider.dart';

class TrackerPage extends StatelessWidget {
  final int index;

  // tracker page constructor
  TrackerPage(this.index);

  @override
  Widget build(BuildContext context) {
    final _trackerProvider = Provider.of<TrackerProvider>(context);
    final _tracker = _trackerProvider.getTracker(index);
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height -
    //     kToolbarHeight -
    //     kBottomNavigationBarHeight -
    //     MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: Text('${_tracker.subheadText}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            _tracker.media,
            width: screenWidth,
            // height: screenHeight * 0.5,
            fit: BoxFit.fitWidth,
          ),
          ListTile(
            title: Text('${_tracker.headText}'),
            subtitle: Text('${_tracker.subheadText}'),
          ),
          Container(
            padding:
                EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_tracker.supportText}',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
