import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20.0,right: 20.0, bottom: 10.0),
      child: Material(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                message.sender == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(message.phoneNumber),
                          Spacer(),
                          Text(message.userName)
                        ],
                      )
                    : Text(message.sender),
                Text(message.text),
                Row(
                  children: [
                    Spacer(),
                    Text(message.time),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
