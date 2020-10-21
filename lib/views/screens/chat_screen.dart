import 'package:aunty_rafiki/constants/routes/routes.dart';

import 'package:aunty_rafiki/sample/model/chat.dart';

import 'package:aunty_rafiki/views/components/tiles/chat_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return StreamBuilder<List<Chat>>(
      stream: db
          .collection('groups')
          .orderBy('name')
          .snapshots()
          .map(firestoreToChatList),
      builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('error: ${snapshot.error.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<Chat> chatList = snapshot.data;
        return ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return ChatTile(
                chat: chatList[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    chatRoomPage,
                    arguments: chatList[index],
                  );
                  //  Navigator.of(context).pushNamed(
                  //     '/chat',
                  //     arguments: chatList[index],
                  //   );
                });

            // ListTile(
            //   title: Text(
            //     chatList[index].name,
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   subtitle: Text(chatList[index].id),
            //   onTap: () {
            //     Navigator.of(context).pushNamed(
            //       '/chat',
            //       arguments: chatList[index],
            //     );
            //   },
            // );
          },
        );
      },
    );
  }
}
