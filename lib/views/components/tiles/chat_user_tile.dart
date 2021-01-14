import 'package:aunty_rafiki/providers/utility_provider.dart';

import 'package:aunty_rafiki/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatUserTile extends StatelessWidget {
  final Chat chat;
  final Function onTap;
  final bool isGroup;

  const ChatUserTile(
      {Key key,
      @required this.chat,
      @required this.onTap,
      @required this.isGroup})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: chat.avatar.isNotEmpty
                        ? NetworkImage(chat.avatar)
                        : isGroup
                            ? AssetImage('assets/icons/aunty_rafiki.png')
                            : AssetImage('assets/icons/female.png'),
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
              _utilityProvider.formatDate(DateTime.parse(chat.time)),
              style: TextStyle(
                  fontSize: 12,
                  color:
                      chat.isMessageRead ? Colors.pink : Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
