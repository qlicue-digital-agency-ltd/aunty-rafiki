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

    final mediaWidth = width * 0.65;
    final noMediaWidth = width * 0.40;
    final formatter = new DateFormat('HH:mm');

    return Container(
      width: originalMessage.media.isEmpty ? noMediaWidth : mediaWidth,
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.pink,
                  height: originalMessage.media.isEmpty ? 40 : 100,
                  width: 5,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      child: RichText(
                          text: TextSpan(
                              text: 'You\n',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              children: <TextSpan>[
                            TextSpan(
                                text: originalMessage.text,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13))
                          ]))),
                ),
                originalMessage.media.isEmpty
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.only(bottom: 2),
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
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  
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
            ),
          )
        ],
      ),
    );

    ///////
  }
}
