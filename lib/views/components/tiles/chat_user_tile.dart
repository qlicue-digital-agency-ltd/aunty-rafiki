
import 'package:aunty_rafiki/models/chat.dart';
import 'package:flutter/material.dart';


class ChatUserTile extends StatelessWidget {
  final Chat chat;
  final Function onTap;

  const ChatUserTile({
    Key key,
    @required this.chat,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: chat.avatar.isNotEmpty
                            ? NetworkImage(chat.avatar)
                            : AssetImage('assets/icons/aunty_rafiki.png'),
                        maxRadius: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(chat.name),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                chat.lastMessage,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontSize: 12,
                      color: chat.isMessageRead
                          ? Colors.pink
                          : Colors.grey.shade500),
                ),
              ],
            ),
            Divider(
              indent: 60,
            )
          ],
        ),
      ),
    );
  }
}
