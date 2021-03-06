import 'package:aunty_rafiki/models/private_message.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/private/private_message.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/private/private_reply_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivateMessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);

    return StreamBuilder<List<PrivateMessage>>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(_chatProvider.privateGroupId)
          .collection(_chatProvider.privateGroupId)
          .orderBy('timestamp', descending: false)
          .limit(_chatProvider.limit)
          .snapshots()
          .map(firestoreToPrivateMessageList),
      builder: (context, AsyncSnapshot<List<PrivateMessage>> snapshot) {
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

        List<PrivateMessage> _data = snapshot.data;
        List<PrivateMessage> docs = _data;
        return Flexible(
          child: ListView.builder(
            controller: _chatProvider.scrollController,
            padding: EdgeInsets.only(bottom: 4),
            itemCount: docs.length,
            itemBuilder: (context, index) => docs[index].repliedUID != null
                ? PrivateReplyChatMessage(
                    orignalMessage: docs
                        .where((sms) => sms.id == docs[index].repliedUID)
                        .first,
                    replyMessage: docs[index],
                    onLongPress: _chatProvider.selectedMessages.isNotEmpty
                        ? null
                        : () {
                            print('okay...');
                            _chatProvider.setPrivateMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    onTap: _chatProvider.selectedMessages.isEmpty
                        ? null
                        : () {
                            print('we good...');
                            _chatProvider.setPrivateMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    color: _chatProvider.selectedMessages
                            .containsKey(docs[index].id)
                        ? Colors.pink[50].withOpacity(0.5)
                        : Colors.transparent)
                : PrivateChatMessage(
                    message: docs[index],
                    onLongPress: _chatProvider.selectedMessages.isNotEmpty
                        ? null
                        : () {
                            print('okay...');
                            _chatProvider.setPrivateMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    onTap: _chatProvider.selectedMessages.isEmpty
                        ? null
                        : () {
                            print('we good...');
                            _chatProvider.setPrivateMessage(
                                message: docs[index], uid: docs[index].id);
                          },
                    color: _chatProvider.selectedMessages
                            .containsKey(docs[index].id)
                        ? Colors.pink[50].withOpacity(0.5)
                        : Colors.transparent),
          ),
        );
      },
    );
  }
}
