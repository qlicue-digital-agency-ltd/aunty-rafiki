import 'package:aunty_rafiki/sample/model/chat.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final Function onTap;

  const ChatTile({Key key, @required this.chat, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: chat.avatar == null
                  ? NetworkImage(chat.avatar)
                  : AssetImage('assets/icons/female.png'),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              chat.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text('chat.messages.last.text')
                          ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              // chat.unreadMessageCounter > 0
                              //     ? CircleAvatar(
                              //         radius: 12,
                              //         backgroundColor:
                              //             Theme.of(context).primaryColor,
                              //         child: Text(
                              //           chat.unreadMessageCounter.toString(),
                              //           style: TextStyle(
                              //               color: Colors.white, fontSize: 12),
                              //         ))
                              //     : Container()
                            ]),
                      ),
                    )
                  ]),
                ),
                Divider()
              ],
            ),
          )
        ]),
      ),
    );
  }
}
