import 'package:aunty_rafiki/models/time_line.dart';
import 'package:flutter/material.dart';

class TimelineDetailPage extends StatelessWidget {
  final Timeline timeline;

  const TimelineDetailPage({Key key, @required this.timeline})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('${timeline.time} month of your pregnancy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              timeline.image,
              width: screenWidth,
              // height: screenHeight * 0.5,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, right: 16.0, bottom: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${timeline.body}',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
