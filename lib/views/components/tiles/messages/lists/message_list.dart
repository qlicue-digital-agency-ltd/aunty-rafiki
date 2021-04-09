import 'package:aunty_rafiki/models/message.dart';

import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';

import 'package:aunty_rafiki/views/components/tiles/messages/message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/reply_message.dart';
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

        List<Message> _data = snapshot.data;
        List<Message> docs = _data;
        return Flexible(
          child: ListView.builder(
            controller: _chatProvider.scrollController,
            padding: EdgeInsets.only(bottom: 4),
            itemCount: docs.length,
            itemBuilder: (context, index) => docs[index].repliedUID != null
                ? ReplyChatMessage(
                    orignalMessage: docs
                        .where((sms) => sms.id == docs[index].repliedUID)
                        .first,
                    replyMessage: docs[index],
                    onLongPress: _chatProvider.selectedMessages.isNotEmpty
                        ? null
                        : () {
                            _chatProvider.setMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    onTap: _chatProvider.selectedMessages.isEmpty
                        ? null
                        : () {
                            _chatProvider.setMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    color: _chatProvider.selectedMessages
                            .containsKey(docs[index].id)
                        ? Colors.pink[50].withOpacity(0.5)
                        : Colors.transparent)
                : ChatMessage(
                    message: docs[index],
                    onLongPress: _chatProvider.selectedMessages.isNotEmpty
                        ? null
                        : () {
                            _chatProvider.setMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    onTap: _chatProvider.selectedMessages.isEmpty
                        ? null
                        : () {
                            print('we good...');
                            _chatProvider.setMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    color: _chatProvider.selectedMessages
                            .containsKey(docs[index].id)
                        ? Colors.pink[100].withOpacity(0.5)
                        : Colors.transparent),
          ),
        );
      },
    );
  }
}
