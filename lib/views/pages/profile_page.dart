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
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/icons/female.png'),
              ),
              Text(
                'Brend',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ]),
            Text('Menu')
          ]),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(profileItem: menuList[index]);
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
          Text('Pregnancy')
        ])),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(profileItem: pregnancyList[index]);
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
          Text('Account')
        ])),
        SliverToBoxAdapter(
          child: Container(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/icons/female.png'),
                      )))),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return ProfileTile(profileItem: accountList[index]);
        }, childCount: accountList.length)),
      ]),
    );
  }
}
