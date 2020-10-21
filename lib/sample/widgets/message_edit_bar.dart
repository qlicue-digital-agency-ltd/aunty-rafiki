import 'package:aunty_rafiki/sample/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageEditBar extends StatefulWidget {
  MessageEditBar();

  @override
  _MessageEditBarState createState() => _MessageEditBarState();
}

class _MessageEditBarState extends State<MessageEditBar> {
  FirebaseFirestore db;
  TextEditingController _controller;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Chat chat = Provider.of<Chat>(context);

    _sendMessage() {
      if (_controller.text.isNotEmpty) {
        db.collection('groups/${chat.id}/messages').add({
          'text': _controller.text,
          'time': Timestamp.fromDate(DateTime.now()),
          'user': 'inventado',
        });
        _controller.clear();
      }
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Material(
              elevation: 2,
              color: Colors.white,
              shape: StadiumBorder(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (text) => _sendMessage(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        Material(
          elevation: 2,
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).primaryColor,
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 6),
      ],
    );
  }
}
