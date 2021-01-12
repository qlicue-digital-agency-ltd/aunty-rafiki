import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/chat.dart';

import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Chat chat;
  const ChatDetailPageAppBar({Key key, @required this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _groupProvider = Provider.of<GroupProvider>(context);
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: chat.avatar.isNotEmpty
                    ? NetworkImage(chat.avatar)
                    : AssetImage('assets/icons/female.png'),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      chat.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<ChatGroupPopMenu>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (ChatGroupPopMenu result) {
                  if (result == ChatGroupPopMenu.ExitGroup) {
                    _groupProvider.leaveGroup(
                        groupUID: chat.id,
                        memberUID: FirebaseAuth.instance.currentUser.uid);
                    Navigator.pop(context);
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<ChatGroupPopMenu>>[
                  const PopupMenuItem<ChatGroupPopMenu>(
                    value: ChatGroupPopMenu.GroupInfo,
                    child: Text('Group Info'),
                  ),
                  const PopupMenuItem<ChatGroupPopMenu>(
                    value: ChatGroupPopMenu.MuteNotification,
                    child: Text('Mute Notifications'),
                  ),
                  const PopupMenuItem<ChatGroupPopMenu>(
                    value: ChatGroupPopMenu.ClearChat,
                    child: Text('Clear Chat'),
                  ),
                  const PopupMenuItem<ChatGroupPopMenu>(
                    value: ChatGroupPopMenu.ExitGroup,
                    child: Text('Exit Group'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
