import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:transparent_image/transparent_image.dart';

class RepliedContent extends StatelessWidget {
  final Message originalMessage;
  final Message replyMessage;

  const RepliedContent(
      {Key key, @required this.originalMessage, @required this.replyMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final constraintsWidth = width * 0.65;
    final formatter = new DateFormat('HH:mm');
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[100]),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.pink,
                height: originalMessage.media.isEmpty ? 60 : 100,
                width: 5,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: constraintsWidth),
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      originalMessage.text,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              originalMessage.media.isEmpty
                  ? SizedBox(
                      width: 20,
                    )
                  : Container(
                      padding: const EdgeInsets.only(right: 4, bottom: 2),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: originalMessage.media[0],
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ],
          ),
        ),
   
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: constraintsWidth),
              padding: EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: Text(
                replyMessage.text,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 4, bottom: 2),
              child: Text(
                '${formatter.format(replyMessage.time)}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        )
      ],
    );

    ///////
  }
}
