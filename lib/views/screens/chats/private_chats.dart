import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';

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
