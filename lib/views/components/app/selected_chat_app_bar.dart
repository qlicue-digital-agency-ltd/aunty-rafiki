import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/chat.dart';

import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:aunty_rafiki/views/components/dialog/custom_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SelectedChatAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Chat chat;
  final List<int> list;
  const SelectedChatAppBar({Key key, @required this.chat, @required this.list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _groupProvider = Provider.of<GroupProvider>(context);
    return AppBar(
      elevation: 0,
      title: Text('${list.length}'),
      actions: [
        IconButton(
            icon: FaIcon(FontAwesomeIcons.reply, color: Colors.white),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.star, color: Colors.white), onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {}),
        IconButton(
            icon: FaIcon(FontAwesomeIcons.share, color: Colors.white),
            onPressed: () {}),
        PopupMenuButton<ChatGroupPopMenu>(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onSelected: (ChatGroupPopMenu result) {
            if (result == ChatGroupPopMenu.ExitGroup) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "Leave Group?",
                      descriptions:
                          "By leaving this group you will not be able to access this group chats",
                      text: "LEAVE",
                      textClose: "CLOSE",
                      onPressed: () {
                        _groupProvider.leaveGroup(
                            groupUID: chat.id,
                            memberUID: FirebaseAuth.instance.currentUser.uid);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      onClose: () {
                        Navigator.pop(context);
                      },
                    );
                  });
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
