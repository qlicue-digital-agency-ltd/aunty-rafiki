import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/sms/replied_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ReplyChatMessage extends StatelessWidget {
  final Message orignalMessage;
  final Message replyMessage;
  final Function onLongPress;
  final Function onTap;
  final Color color;
  ReplyChatMessage(
      {this.orignalMessage,
      this.replyMessage,
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
                FirebaseAuth.instance.currentUser.uid == replyMessage.sender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: RepliedContent(
                      originalMessage: orignalMessage,
                      replyMessage: replyMessage,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
