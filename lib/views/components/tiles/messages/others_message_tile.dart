import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/views/components/cards/media/audio_card.dart';

import 'package:aunty_rafiki/views/components/cards/message/double_media.dart';
import 'package:aunty_rafiki/views/components/cards/message/no_media.dart';
import 'package:aunty_rafiki/views/components/cards/message/quardripple_media.dart';
import 'package:aunty_rafiki/views/components/cards/message/single_media.dart';
import 'package:aunty_rafiki/views/components/cards/message/tripple_media.dart';
import 'package:flutter/material.dart';

class OthersMessageTile extends StatelessWidget {
  final Message message;
  final String chatType;

  const OthersMessageTile(
      {Key key, @required this.message, @required this.chatType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 0),
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Colors.white),
        child: Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  chatType == 'group'
                      ? ((message.sender == null
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(message.phoneNumber),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(message.userName)
                              ],
                            )
                          : Text(message.sender)))
                      : Container(
                          width: 0,
                        ),
                  message.audio != null
                      ? AudioCard(audio: message.audio)
                      : message.media == null
                          ? NoMedia(message: message)
                          : message.media.length == 1
                              ? SingleMedia(
                                  message: message,
                                )
                              : message.media.length == 2
                                  ? DoubleMedia(message: message)
                                  : message.media.length == 3
                                      ? TrippleMedia(message: message)
                                      : QuardrippleMedia(
                                          message: message,
                                        ),
                ])),
      ),
    );
  }
}
