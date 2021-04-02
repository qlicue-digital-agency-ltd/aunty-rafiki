import 'package:aunty_rafiki/providers/group_provider.dart';
import 'package:aunty_rafiki/providers/user_provider.dart';
import 'package:aunty_rafiki/views/components/image/profile_avatar.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  FirebaseFirestore db;

  TextEditingController _controller = TextEditingController();

  FocusNode _focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    final _groupProvider = Provider.of<GroupProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New group'),
              Text('Add subject', style: TextStyle(fontSize: 14)),
              SizedBox(height: 10)
            ],
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 150),
            child: Container(
              height: 150,
              color: Colors.white,
              child: Stack(
                children: [
                  Material(
                      elevation: 2,
                      child: Container(
                        color: Colors.white70,
                        height: 125,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _groupProvider.openFileExplorer();
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        _groupProvider.files.isNotEmpty
                                            ? FileImage(_groupProvider.files[0])
                                            : null,
                                    radius: 30,
                                    child: _groupProvider.files.isEmpty
                                        ? Icon(Icons.camera_alt)
                                        : Container(),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: _focusNode,
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return "Group name required";
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText:
                                              'Type group subject here..'),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.face,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {})
                              ],
                            ),
                            Text(
                                'Provide a group subject and optional group icon')
                          ]),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: TextButton(
                        // shape: CircleBorder(),
                        // color: Theme.of(context).primaryColor,
                        onPressed: _groupProvider.isCreatingGroup
                            ? null
                            : () {
                                if (_formKey.currentState.validate()) {
                                  _groupProvider
                                      .createUserGroup(
                                    name: _controller.text,
                                    time: Timestamp.fromDate(DateTime.now()),
                                    groupMembers: _userProvider.selectedUser,
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    _userProvider.clearAllSelectedUsers();
                                  });
                                }
                              },
                        child: Container(
                          height: 50,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
            )),
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Center(
                child: Text(
                    '${_userProvider.selectedUser.length} / ${_userProvider.originalAvailableUsers.length} participants'))
          ]),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ProfileAvatar(
                user: _userProvider.selectedUser[index],
                onTap: () {
                  _userProvider.removeUser(
                      indexSelectedUser: index,
                      user: _userProvider.selectedUser[index]);
                },
              );
            },
            childCount: _userProvider.selectedUser.length,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _groupProvider.isCreatingGroup
                ? Center(child: Loading())
                : Container()
          ]),
        ),
      ]),
    );
  }
}
