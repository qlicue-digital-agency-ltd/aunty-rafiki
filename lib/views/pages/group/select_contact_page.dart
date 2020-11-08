import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/models/user.dart';
import 'package:aunty_rafiki/views/components/image/profile_avatar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('New group'),
            Text('Add participants', style: TextStyle(fontSize: 14)),
            SizedBox(height: 10)
          ],
        ),
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Container(
              height: 120,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return ProfileAvatar();
                  }),
            )),
      ),
      body: StreamBuilder<List<User>>(
        stream: db
            .collection('users')
            .orderBy('displayName')
            .snapshots()
            .map(firestoreToUserList),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          print(' peep popeo ppol');
          if (snapshot.hasError) {
            return Center(child: Text('error: ${snapshot.error.toString()}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<User> userList = snapshot.data;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              
              return InkWell(
                onTap: () {
                  print(userList[index].displayName);
                },
                child: Container(
                  height: 100,
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                          radius: 35,
                          // backgroundImage: userList[index].photoUrl != 'null'
                          //     ? NetworkImage(userList[index].photoUrl)
                          //     : AssetImage('assets/icons/female.png'),
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
                                        userList[index].displayName.toString(),
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

              // ContactTile(
              //   onTap: () {},
              //   user: userList[index],
              // );
            },
          );
        },
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
