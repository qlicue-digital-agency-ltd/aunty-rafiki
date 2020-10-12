import 'package:aunty_rafiki/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Profile profileItem;

  const ProfileTile({Key key, @required this.profileItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(profileItem.icon, color: Theme.of(context).primaryColor,),
      title: Text(profileItem.title),

    );
  }
}
