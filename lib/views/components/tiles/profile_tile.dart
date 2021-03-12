import 'package:aunty_rafiki/models/view/profile.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Profile profileItem;
  final Function onTap;

  const ProfileTile({Key key, @required this.profileItem, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        profileItem.icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(profileItem.title),
    );
  }
}
