import 'package:aunty_rafiki/models/private_message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/private/private_replied_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrivateReplyChatMessage extends StatelessWidget {
  final PrivateMessage orignalMessage;
  final PrivateMessage replyMessage;
  final Function onLongPress;
  final Function onTap;
  final Color color;
  PrivateReplyChatMessage(
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
                FirebaseAuth.instance.currentUser.uid == replyMessage.idFrom
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: PrivateRepliedContent(
                        originalMessage: orignalMessage,
                        replyMessage: replyMessage,
                        byMe: FirebaseAuth.instance.currentUser.uid ==
                            orignalMessage.idFrom)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
