import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/models/profile.dart';
import 'package:aunty_rafiki/views/components/tiles/profile_tile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/icons/female.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Brend',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ]),
              ),
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
            },
          );
        }, childCount: accountList.length)),
      ]),
    );
  }
}
