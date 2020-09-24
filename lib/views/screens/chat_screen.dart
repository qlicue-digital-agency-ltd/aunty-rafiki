import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';

import 'package:aunty_rafiki/views/components/tiles/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return ListView.builder(
        itemCount: _chatProvider.chatList.length,
        itemBuilder: (_, index) {
          return ChatTile(
              chat: _chatProvider.chatList[index],
              onTap: () {
                _chatProvider.selectChat = _chatProvider.chatList[index];
                Navigator.pushNamed(context, chatRoomPage);
              });
        });
  }
}
