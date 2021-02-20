import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoMediaContent extends StatelessWidget {
  final Message message;

  const NoMediaContent({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final formatter = new DateFormat('HH:mm');
    return 
    
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: width - 80),
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 4,
          ),
          child: Text(
            message.text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 4, bottom: 2),
          child: Text(
            '${formatter.format(message.time)}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
