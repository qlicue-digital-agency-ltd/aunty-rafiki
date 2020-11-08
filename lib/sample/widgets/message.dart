import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/sample/widgets/message/media_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message/no_media_content.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  ChatMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: FirebaseAuth.instance.currentUser.uid == message.sender
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
                  : MediaContent(
                      message: message,
                      width: MediaQuery.of(context).size.width,
                    )),
        ),
      ],
    );
  }
}
