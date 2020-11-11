import 'package:aunty_rafiki/models/tracker.dart';
import 'package:flutter/material.dart';

class TrackerPage extends StatelessWidget {
  final Tracker tracker;

  const TrackerPage({Key key, @required this.tracker}) : super(key: key);



  @override
  Widget build(BuildContext context) {
   
    final screenWidth = MediaQuery.of(context).size.width;

 

    return Scaffold(
      appBar: AppBar(
        title: Text('${tracker.subtitle}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              tracker.media,
              width: screenWidth,
              // height: screenHeight * 0.5,
              fit: BoxFit.fitWidth,
            ),
            ListTile(
              title: Text('${tracker.title}'),
              subtitle: Text('${tracker.subtitle}'),
              trailing: Image.asset('assets/icons/nurse.jpeg'),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tracker.body}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text('What is Normal?'),
              subtitle: Text('${tracker.subtitle}'),
              trailing: Image.asset('assets/icons/okay.jpeg'),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tracker.body}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text('What is Abnormal?'),
              subtitle: Text('${tracker.subtitle}'),
              trailing: Image.asset('assets/icons/not.jpeg'),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tracker.body}',
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
