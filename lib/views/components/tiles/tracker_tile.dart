import 'package:aunty_rafiki/models/tracker.dart';
import 'package:flutter/material.dart';

class TrackerTile extends StatelessWidget {
  final Tracker tracker;
  final Function onTap;

  const TrackerTile({Key key, @required this.tracker, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              onTap: onTap,
              title: Text('${tracker.week} WEEKS'),
              subtitle: Text(tracker.title, maxLines: 1,),
              trailing: Icon( tracker.show ? Icons.arrow_drop_up:  Icons.arrow_drop_down, color: Colors.pink),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
