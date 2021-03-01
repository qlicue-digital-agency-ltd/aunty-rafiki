import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoMediaContent extends StatelessWidget {
  final Message message;
  final bool byMe;

  const NoMediaContent({Key key, @required this.message, @required this.byMe})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final formatter = new DateFormat('HH:mm');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
            constraints: BoxConstraints(maxWidth: width - 80),
            padding: EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            child: RichText(
                text: TextSpan(
                    text: byMe ? "" : '${message.senderName}\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    children: <TextSpan>[
                  TextSpan(
                      text: message.text,
                      style: TextStyle(color: Colors.black45, fontSize: 15))
                ]))
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
