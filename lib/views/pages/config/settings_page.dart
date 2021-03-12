import 'package:aunty_rafiki/models/view/profile.dart';
import 'package:aunty_rafiki/views/components/tiles/profile_tile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Profile> accountList = <Profile>[
      Profile(icon: Icons.person_add, title: 'Firstaname'),
      Profile(icon: Icons.person, title: 'Lastname'),
      Profile(icon: Icons.calendar_today, title: 'Age'),
      Profile(icon: Icons.personal_video, title: 'You are the '),
      Profile(icon: Icons.exit_to_app, title: 'Logout')
    ];

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
