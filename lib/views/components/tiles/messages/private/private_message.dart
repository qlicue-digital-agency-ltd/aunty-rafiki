import 'package:aunty_rafiki/models/private_message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/private/private_media_content.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/private/private_no_media_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrivateChatMessage extends StatelessWidget {
  final PrivateMessage message;
  final Function onLongPress;
  final Function onTap;
  final Color color;
  PrivateChatMessage(
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
                FirebaseAuth.instance.currentUser.uid == message.idFrom
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: message.media.isEmpty
                        ? PrivateNoMediaContent(
                            message: message,
                            byMe: FirebaseAuth.instance.currentUser.uid ==
                                message.idFrom,
                          )
                        : PrivateMediaContent(
                            message: message,
                            width: MediaQuery.of(context).size.width,
                            byMe: FirebaseAuth.instance.currentUser.uid ==
                                message.idFrom,
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
