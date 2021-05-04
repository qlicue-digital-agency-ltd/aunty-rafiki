import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/private_message.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';

import 'package:aunty_rafiki/views/components/dialog/custom_dialog_box.dart';

import 'package:aunty_rafiki/views/components/dialog/private_custom_dialog_two_box.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PrivateSelectedChatAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Map<String, PrivateMessage> listMessage;
  const PrivateSelectedChatAppBar({Key key, @required this.listMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        '${listMessage.length}',
        style: TextStyle(color: Colors.black54),
      ),
      actions: [
        listMessage.length == 1
            ? IconButton(
                icon: FaIcon(FontAwesomeIcons.reply, color: Colors.black54),
                onPressed: () {
                  String key = listMessage.keys.elementAt(0);
                  _chatProvider.setPrivateMessageToReply = listMessage[key];
                  _chatProvider.clearSelectedChats();
                })
            : Container(),
        IconButton(
            icon: Icon(Icons.star, color: Colors.black54), onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black54,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PrivateCustomDialogTwoBox(
                      onDeleteOne: () {
                        _chatProvider
                            .deletePrivateChatMessage(
                          choice: 'me_only',
                          userUID: FirebaseAuth.instance.currentUser.uid,
                        )
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      onClose: () {
                        Navigator.pop(context);
                        _chatProvider.clearSelectedChats();
                      },
                      onDeleteTwo: () {
                        _chatProvider
                            .deletePrivateChatMessage(
                          choice: 'both_of_us',
                          userUID: null,
                        )
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      listMessage: listMessage,
                    );
                  });
            }),
        IconButton(
            icon: FaIcon(FontAwesomeIcons.share, color: Colors.black54),
            onPressed: () {}),
        PopupMenuButton<ChatGroupPopMenu>(
          icon: Icon(
            Icons.more_vert,
            color: Colors.black54,
          ),
          onSelected: (ChatGroupPopMenu result) {
            if (result == ChatGroupPopMenu.ExitGroup) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "Clear Chat?",
                      descriptions:
                          "By clearing this chat you will not be able to access all messages again",
                      text: "CLEAR",
                      textClose: "CLOSE",
                      onPressed: () {
                        // _groupProvider.leaveGroup(
                        //     groupUID: chat.id,
                        //     memberUID: FirebaseAuth.instance.currentUser.uid);
                        // Navigator.pop(context);
                        // Navigator.pop(context);
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
