import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/audio_media_content.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/media_content.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/video_media_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sms/no_media_content.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  final Function onLongPress;
  final Function onTap;
  final Color color;
  ChatMessage(
      {this.message,
      @required this.onLongPress,
      @required this.onTap,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Container(
          color: color,
          child: Row(
            mainAxisAlignment:
                FirebaseAuth.instance.currentUser.uid == message.sender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: message.media.isEmpty
                        ? NoMediaContent(
                            message: message,
                            byMe: FirebaseAuth.instance.currentUser.uid ==
                                message.sender,
                          )
                        : message.mediaType == "image"
                            ? MediaContent(
                                message: message,
                                width: MediaQuery.of(context).size.width,
                                byMe: FirebaseAuth.instance.currentUser.uid ==
                                message.sender,
                              )
                            : message.mediaType == "audio"
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: PlayerWidget(
                                      message: message,
                                      width: MediaQuery.of(context).size.width,
                                    ))
                                : VideoMediaContent(
                                    message: message,
                                    width: MediaQuery.of(context).size.width,
                                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
