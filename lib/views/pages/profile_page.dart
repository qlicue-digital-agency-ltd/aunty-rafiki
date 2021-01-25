import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/models/profile.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/profile_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, editProfilePage);
                  },
                  child: FutureBuilder<DocumentSnapshot>(
                    future:
                        users.doc(FirebaseAuth.instance.currentUser.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data = snapshot.data.data();
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: data['photoURL'] == null
                                    ? AssetImage('assets/icons/female.png')
                                    : NetworkImage(data['photoURL']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                data['displayName'] != null
                                    ? '${data['displayName']}'
                                    : "No Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ]);
                      }

                      return Text("loading");
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Menu', style: TextStyle(fontSize: 18)),
            ),
          ]),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(
            profileItem: menuList[index],
            onTap: () {
              _authProvider.signOut();
              print(menuList[index].title);
            },
          );
        }, childCount: menuList.length)),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Pregnancy', style: TextStyle(fontSize: 18)),
          ),
        ])),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(
            profileItem: pregnancyList[index],
            onTap: () {
              print(pregnancyList[index].title);
            },
          );
        }, childCount: pregnancyList.length)),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Account', style: TextStyle(fontSize: 18)),
          ),
        ])),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(
            profileItem: accountList[index],
            onTap: () {
              print(accountList[index].title);
              if (accountList[index].title == 'Logout') {
                _authProvider.signOut().then((value) => {
                  Navigator.pushNamed(context, landingPage)
                });
              }
            },
          );
        }, childCount: accountList.length)),
      ]),
    );
  }
}
