import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/audio_media_content.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/media_content.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/video_media_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sms/no_media_content.dart';

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';

class ChatMessage extends StatelessWidget {
  final Message message;
  final Function onLongPress;
  ChatMessage({this.message, @required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
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
                    ? NoMediaContent(message: message)
                    : message.mediaType == "image"
                        ? MediaContent(
                            message: message,
                            width: MediaQuery.of(context).size.width,
                          )
                        : message.mediaType == "audio"
                            ? Container(
                                width: MediaQuery.of(context).size.width / 2,
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
    );
  }
}
