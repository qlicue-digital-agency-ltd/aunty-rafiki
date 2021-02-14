import 'package:aunty_rafiki/models/message.dart';

import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';

import 'package:aunty_rafiki/views/components/tiles/messages/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    Chat chat = Provider.of<Chat>(context);

    return StreamBuilder<List<Message>>(
      stream: FirebaseFirestore.instance
          .collection('groups/${chat.id}/messages')
          .where("members",
              arrayContainsAny: ['${FirebaseAuth.instance.currentUser.uid}'])
          .orderBy('time', descending: false)
          .snapshots()
          .map(firestoreToMessageList),
      builder: (context, AsyncSnapshot<List<Message>> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Flexible(
            child: Center(
              child: Text('ERROR: ${snapshot.error.toString()}'),
            ),
          );
        }
        if (!snapshot.hasData) {
          return Flexible(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        List<Message> docs = snapshot.data;
        return Flexible(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 4),
            itemCount: docs.length,
            itemBuilder: (context, index) => ChatMessage(
                message: docs[index],
                onLongPress: _chatProvider.selectedMessages.isNotEmpty
                    ? null
                    : () {
                        print('okay...');
                        _chatProvider.setMessage = docs[index].id;
                      },
                onTap: _chatProvider.selectedMessages.isEmpty
                    ? null
                    : () {
                        print('we good...');
                        _chatProvider.setMessage = docs[index].id;
                      },
                color: _chatProvider.selectedMessages.contains(docs[index].id)
                    ? Colors.pink[50].withOpacity(0.5)
                    : Colors.transparent),
          ),
        );
      },
    );
  }
}
