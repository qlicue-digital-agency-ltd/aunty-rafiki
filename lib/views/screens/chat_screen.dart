import 'package:aunty_rafiki/views/screens/chats/group_chats.dart';
import 'package:aunty_rafiki/views/screens/chats/private_chats.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [GroupChats(), PrivateChats()],
    );
  }
}
