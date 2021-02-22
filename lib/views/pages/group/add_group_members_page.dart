import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:aunty_rafiki/providers/user_provider.dart';

import 'package:aunty_rafiki/views/components/image/profile_avatar.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGroupMemberPage extends StatefulWidget {
  final Chat chat;

  const AddGroupMemberPage({Key key, @required this.chat}) : super(key: key);
  @override
  _AddGroupMemberPageState createState() => _AddGroupMemberPageState();
}

class _AddGroupMemberPageState extends State<AddGroupMemberPage> {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    final _groupProvider = Provider.of<GroupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Participants'),
      ),
      body: Stack(
        children: [
          _userProvider.availableUsersToAdd.isEmpty &&
                  _userProvider.selectedUser.isEmpty
              ? Center(
                  child: NoItemTile(
                      icon: 'assets/icons/aunty_rafiki.png',
                      title: 'No users under your ID'),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 120),
                  itemCount: _userProvider.availableUsersToAdd.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(_userProvider
                            .availableUsersToAdd[index].displayName);
                        _userProvider.selectUsersToAdd(
                            index: index,
                            user: _userProvider.availableUsersToAdd[index]);
                      },
                      child: Container(
                        height: 100,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('assets/icons/female.png')),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _userProvider
                                                  .availableUsersToAdd[index]
                                                  .displayName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Text('pop')
                                          ]),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[]),
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
                  },
                ),
          _userProvider.availableUsersToAdd.isEmpty &&
                  _userProvider.selectedUser.isEmpty
              ? Container()
              : Container(
                  height: 120,
                  color: Colors.black12,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _userProvider.selectedUser.length,
                      itemBuilder: (_, index) {
                        return ProfileAvatar(
                          user: _userProvider.selectedUser[index],
                          onTap: () {
                            _userProvider.removeUsersToAdd(
                                index: index,
                                user: _userProvider.selectedUser[index]);
                          },
                        );
                      }),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _userProvider.selectedUser.isEmpty
            ? null
            : () {
                _groupProvider
                    .addToGroup(
                  users: _userProvider.selectedUser,
                  groupUID: widget.chat.id,
                )
                    .then((value) {
                 
                  Navigator.pop(context);
                  _userProvider.clearAllSelectedUsersToAdd();
                });
              },
        child: Center(child: Icon(Icons.add)),
      ),
    );
  }
}
