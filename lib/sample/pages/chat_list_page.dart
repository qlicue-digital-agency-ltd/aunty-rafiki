
import 'package:aunty_rafiki/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WhatsApp'),
      ),
      body: StreamBuilder<List<Chat>>(
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
              return ListTile(
                title: Text(
                  chatList[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(chatList[index].id),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/chat',
                    arguments: chatList[index],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/new').then((groupName) {
            String name = groupName;
            if (name != null && name.isNotEmpty) {
              db.collection('groups').doc().set({
                'name': groupName,
              });
            }
          });
        },
      ),
    );
  }
}
