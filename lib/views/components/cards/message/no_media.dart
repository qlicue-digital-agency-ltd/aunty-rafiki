import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoMedia extends StatelessWidget {
  final Message message;

  const NoMedia({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(message.text,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300)),
            SizedBox(height: 20),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            DateFormat('Hm').format(message.date),
            style: TextStyle(color: Colors.black38),
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}
