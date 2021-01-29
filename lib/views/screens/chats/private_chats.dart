import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';

import 'package:aunty_rafiki/models/chat.dart';

import 'package:aunty_rafiki/views/components/tiles/chat_user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrivateChats extends StatefulWidget {
  @override
  _PrivateChatsState createState() => _PrivateChatsState();
}

class _PrivateChatsState extends State<PrivateChats> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: NoItemTile(
      icon: 'assets/icons/chat.png',
      title: 'Coming soon !!',
    ));
  }
}
