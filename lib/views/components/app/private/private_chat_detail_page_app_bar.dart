
import 'package:aunty_rafiki/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivateChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final User peer;
  const PrivateChatDetailPageAppBar({Key key, @required this.peer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                backgroundImage: peer.photoUrl != null
                    ? NetworkImage(peer.photoUrl)
                    : AssetImage('assets/icons/female.png'),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => GroupInfoPage(chat: chat)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${peer.displayName}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // PopupMenuButton<ChatGroupPopMenu>(
              //   icon: Icon(
              //     Icons.more_vert,
              //     color: Colors.white,
              //   ),
              //   onSelected: (ChatGroupPopMenu result) {
              //     if (result == ChatGroupPopMenu.GroupInfo) {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (_) => GroupInfoPage(chat: chat)));
              //     }
              //   },
              //   itemBuilder: (BuildContext context) =>
              //       <PopupMenuEntry<ChatGroupPopMenu>>[
              //     const PopupMenuItem<ChatGroupPopMenu>(
              //       value: ChatGroupPopMenu.GroupInfo,
              //       child: Text('Group Info'),
              //     ),
              //     const PopupMenuItem<ChatGroupPopMenu>(
              //       value: ChatGroupPopMenu.MuteNotification,
              //       child: Text('Mute Notifications'),
              //     ),
              //     const PopupMenuItem<ChatGroupPopMenu>(
              //       value: ChatGroupPopMenu.ClearChat,
              //       child: Text('Clear Chat'),
              //     ),
              //   ],
              // )
          
          
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
