import 'package:aunty_rafiki/models/tracker.dart';
import 'package:flutter/material.dart';

class TrackerBlogPage extends StatelessWidget {
  final Tracker tracker;

  const TrackerBlogPage({Key key, @required this.tracker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text('${tracker.subtitle}', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tracker.images.isEmpty
                ? Image.asset(
                    'assets/images/img_not_available.jpeg',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    tracker.images.last.url,
                    width: screenWidth,
                    // height: screenHeight * 0.5,
                    fit: BoxFit.fitWidth,
                  ),
            ListTile(
              title: Text('${tracker.title}'),
              subtitle: Text('${tracker.subtitle}'),
              trailing: Text(
                "👩‍⚕️",
                style: TextStyle(fontSize: 50),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text('6 minute read'),
              trailing: Text(
                "⏰",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tracker.content}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
