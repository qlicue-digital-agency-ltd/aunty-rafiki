import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/models/user.dart';
import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:aunty_rafiki/providers/user_provider.dart';
import 'package:aunty_rafiki/views/components/dialog/custom_dialog_box.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/user_tile.dart';
import 'package:aunty_rafiki/views/pages/private_chat_room_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'group/add_group_members_page.dart';

class GroupInfoPage extends StatelessWidget {
  final Chat chat;

  const GroupInfoPage({Key key, @required this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _groupProvider = Provider.of<GroupProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);

    Future<void> _showMyDialog({@required User user}) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivateChatRoomPage(
                                    peer: user,
                                  )));
                    },
                    title: Text('Message ${user.displayName}'),
                  ),
                  ListTile(
                    onTap: () {
                      print('view');
                      Navigator.of(context).pop();
                    },
                    title: Text('View ${user.displayName}'),
                  ),
                  ListTile(
                    onTap: () {
                      print('make group admin');
                      _groupProvider
                          .makeGroupAdmin(
                              groupUID: chat.id,
                              memberUID: user.uid,
                              status: true)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    title: Text('Make group Admin'),
                  ),
                  ListTile(
                    onTap: () {
                      print('remove');
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Remove from Group?",
                              descriptions:
                                  "By removing ${user.displayName} from this group they will not be able to access this group's chats",
                              text: "Remove",
                              textClose: "CLOSE",
                              onPressed: () {
                                _groupProvider.leaveGroup(
                                    groupUID: chat.id, memberUID: user.uid);
                                Navigator.pop(context);
                              },
                              onClose: () {
                                Navigator.pop(context);
                              },
                            );
                          });
                    },
                    title: Text('Remove ${user.displayName}'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            actions: [
              // IconButton(
              //   icon: Icon(
              //     Icons.edit,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {},
             // )
            ],
            onStretchTrigger: () {
              return;
            },
            flexibleSpace: FlexibleSpaceBar(
              title: RichText(
                  text: TextSpan(
                      text: chat.name + '\n',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'created by robbyn on 12/12/2020',
                        style: TextStyle(color: Colors.black, fontSize: 9))
                  ])),
              centerTitle: false,
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              background: chat.avatar.isNotEmpty
                  ? FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: chat.avatar,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icons/aunty_rafiki.png',
                      fit: BoxFit.cover,
                    ),
            )),
        SliverList(
          delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                print('LOVE');
              },
              child: Material(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20, bottom: 20),
                    child: Row(children: [
                      Expanded(child: Text('Add group description'))
                    ]),
                  )),
            ),
            SizedBox(height: 20),
            Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Mute Notifications')),
                        Switch(
                            value: true,
                            onChanged: (value) {
                              print(value);
                            })
                      ],
                    ),
                    Divider(indent: 10),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(child: Text('Media Visibility')),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(indent: 20),
                  ],
                ),
              ),
            )
          ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: Text(
                    '${_groupProvider.currentGroupMembers.length} participants'),
              ),
            ),
            Material(
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  _userProvider.getUsersToAdd(users: chat.members);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddGroupMemberPage(
                                chat: chat,
                              )));
                },
                leading: CircleAvatar(child: Icon(Icons.person_add)),
                title: Text('Add participants'),
              ),
            ),
            Material(color: Colors.white, child: Divider(indent: 20)),
            Visibility(
              child: Center(child: Loading()),
              visible: _groupProvider.loadingMembers,
            )
          ]),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return UserTile(
            user: _groupProvider.currentGroupMembers[index],
            onTap: () {
              _showMyDialog(user: _groupProvider.currentGroupMembers[index]);
            },
          );
        }, childCount: _groupProvider.currentGroupMembers.length)),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            Material(
                color: Colors.white,
                child: ListTile(
                  onTap: () {
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
                                  memberUID: firebaseUser
                                      .FirebaseAuth.instance.currentUser.uid);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            onClose: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Exit Group'),
                )),
            SizedBox(height: 20),
          ]),
        ),
      ]),
    );
  }
}
