import 'package:flutter/material.dart';

class Profile {
  final IconData icon;
  final String title;
  Widget trailing;

  Profile({@required this.icon, @required this.title});
}

List<Profile> menuList = <Profile>[
  Profile(icon: Icons.settings, title: 'Settings'),
  Profile(icon: Icons.ac_unit, title: 'About Us'),
  Profile(icon: Icons.contact_phone, title: 'Contant Us'),
  Profile(icon: Icons.personal_video, title: 'privacy Policy')
];

List<Profile> pregnancyList = <Profile>[
  Profile(icon: Icons.search, title: 'Baby Sex'),
  Profile(icon: Icons.keyboard, title: 'Baby Name'),
  Profile(icon: Icons.dashboard, title: 'Due Date'),
  Profile(icon: Icons.call, title: 'Due Date Calculator')
];

List<Profile> accountList = <Profile>[
  Profile(icon: Icons.person_add, title: 'Firstaname'),
  Profile(icon: Icons.person, title: 'Lastname'),
  Profile(icon: Icons.calendar_today, title: 'Age'),
  Profile(icon: Icons.personal_video, title: 'You are the '),
  Profile(icon: Icons.exit_to_app, title: 'Logout')
];
