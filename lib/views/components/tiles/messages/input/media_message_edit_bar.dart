import 'dart:io';

import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class MediaMessageEditBar extends StatefulWidget {
  final Function onPressed;
  final Chat chat;
  const MediaMessageEditBar({Key key, this.onPressed, @required this.chat})
      : super(key: key);

  @override
  _MediaMessageEditBarState createState() => _MediaMessageEditBarState();
}

class _MediaMessageEditBarState extends State<MediaMessageEditBar> {
  FirebaseFirestore db;
  TextEditingController _controller;
  List<Asset> images = List<Asset>();
  bool _isSending = false;
  @override
  void initState() {
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Material(
              elevation: 2,
              color: Colors.white,
              shape: StadiumBorder(),
              child: Row(
                children: [
                  IconButton(
                    icon: new Icon(Icons.add_a_photo),
                    onPressed: () {
                      _chatProvider
                          .openFileExplorer(
                              pickingType: FileType.image,
                              allowedExtensions: null,
                              multiPick: true)
                          .then((val) {});
                    },
                    color: Colors.black26,
                  ),
                  Container(
                    color: Colors.black26,
                    width: 2,
                    height: 35,
                  ),
                  Flexible(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      child: TextField(
                        controller: _controller,
                        enabled: !_isSending,
                        onSubmitted: (text) {
                          _chatProvider
                              .sendMessage(
                                  text: _controller.text,
                                  time: Timestamp.fromDate(DateTime.now()),
                                  user: FirebaseAuth.instance.currentUser.uid,
                                  chat: widget.chat,
                                  repliedMessage: _chatProvider.messageToReply)
                              .then((value) {
                            _controller.clear();
                            Navigator.pop(context);
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add a caption...'),
                      ),
                    ),
                  ),
                ],
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
            icon: _isSending
                ? Center(
                    child: Platform.isIOS
                        ? Theme(
                            data: ThemeData(
                                cupertinoOverrideTheme: CupertinoThemeData(
                                    brightness: Brightness.dark)),
                            child: CupertinoActivityIndicator())
                        : CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ))
                : Icon(Icons.send),
            onPressed: _isSending
                ? null
                : () {
                    setState(() {
                      _isSending = true;
                    });
                    _chatProvider
                        .sendMessage(
                            text: _controller.text,
                            time: Timestamp.fromDate(DateTime.now()),
                            user: FirebaseAuth.instance.currentUser.uid,
                            chat: widget.chat,
                            repliedMessage: _chatProvider.messageToReply)
                        .then((value) {
                      _controller.clear();
                      setState(() {
                        _isSending = false;
                      });
                      Navigator.pop(context);
                    });
                  },
            color: Colors.white,
          ),
        ),
        SizedBox(width: 6),
      ],
    );
  }
}
