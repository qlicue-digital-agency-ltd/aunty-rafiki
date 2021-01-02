
import 'package:aunty_rafiki/models/profile.dart';
import 'package:aunty_rafiki/views/components/tiles/profile_tile.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: CustomScrollView(slivers: [
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
