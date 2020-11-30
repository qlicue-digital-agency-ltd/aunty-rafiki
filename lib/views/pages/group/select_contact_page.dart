import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/user_provider.dart';
import 'package:aunty_rafiki/views/components/app/select_contact_page_app_bar.dart';
import 'package:aunty_rafiki/views/components/image/profile_avatar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectContactPage extends StatefulWidget {
  @override
  _SelectContactPageState createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: SelectContactPageAppBar(),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top: 120),
            itemCount: _userProvider.availableUsers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print(_userProvider.availableUsers[index].displayName);
                  _userProvider.selectUser(
                      indexAvailableUser: index,
                      user: _userProvider.availableUsers[index]);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _userProvider
                                            .availableUsers[index].displayName
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
                                  padding: const EdgeInsets.only(right: 10),
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
          Container(
            height: 120,
            color: Colors.white,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _userProvider.selectedUser.length,
                itemBuilder: (_, index) {
                  return ProfileAvatar(
                    user: _userProvider.selectedUser[index],
                    onTap: () {
                      _userProvider.removeUser(
                          indexSelectedUser: index,
                          user: _userProvider.selectedUser[index]);
                    },
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, createGroupPage);
        },
        child: Center(child: Icon(Icons.arrow_forward)),
      ),
    );
  }
}
