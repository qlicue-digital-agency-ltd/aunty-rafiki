import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/models/time_line.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  'images/img_not_available.jpeg',
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              imageUrl: timeline.image,
              width: screenWidth,
              fit: BoxFit.fill,
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
