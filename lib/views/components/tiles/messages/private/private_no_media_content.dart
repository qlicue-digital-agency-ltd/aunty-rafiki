import 'package:aunty_rafiki/models/private_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivateNoMediaContent extends StatelessWidget {
  final PrivateMessage message;
  final bool byMe;

  const PrivateNoMediaContent(
      {Key key, @required this.message, @required this.byMe})
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
                    text: message.content,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    children: <TextSpan>[]))),
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
