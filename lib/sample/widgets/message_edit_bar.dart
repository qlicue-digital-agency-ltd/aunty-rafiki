import 'dart:io' as io;
import 'dart:math';
import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class MessageEditBar extends StatefulWidget {
  final LocalFileSystem localFileSystem;
  final Function onPressed;

  const MessageEditBar({Key key, this.onPressed, localFileSystem})
      : this.localFileSystem = localFileSystem,
        super(key: key);

  @override
  _MessageEditBarState createState() => _MessageEditBarState();
}

class _MessageEditBarState extends State<MessageEditBar> {
  FirebaseFirestore db;
  TextEditingController _controller;
  List<Asset> images = List<Asset>();
  bool _isSending = false;
  bool _isAudio = true;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Chat chat = Provider.of<Chat>(context);

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
                    icon: new Icon(Icons.add),
                    onPressed: widget.onPressed,
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
                        enabled: !_isSending,
                        controller: _controller,
                        onChanged: (val) {
                          if (val.isEmpty) {
                            setState(() {
                              _isAudio = true;
                            });
                          } else {
                            setState(() {
                              _isAudio = false;
                            });
                          }
                        },
                        onSubmitted: (text) {
                          _chatProvider
                              .sendMessage(
                                  text: _controller.text,
                                  time: Timestamp.fromDate(DateTime.now()),
                                  user: FirebaseAuth.instance.currentUser.uid,
                                  chat: chat)
                              .then((value) {
                            _controller.clear();
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Type here...'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _isAudio
            ? Material(
                elevation: 2,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: _isSending
                      ? Center(
                          child: io.Platform.isIOS
                              ? Theme(
                                  data: ThemeData(
                                      cupertinoOverrideTheme:
                                          CupertinoThemeData(
                                              brightness: Brightness.dark)),
                                  child: CupertinoActivityIndicator())
                              : CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ))
                      : Icon(Icons.mic),
                  onPressed: () {},
                  color: Colors.white,
                ),
              )
            : Material(
                elevation: 2,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                color: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: _isSending
                      ? Center(
                          child: io.Platform.isIOS
                              ? Theme(
                                  data: ThemeData(
                                      cupertinoOverrideTheme:
                                          CupertinoThemeData(
                                              brightness: Brightness.dark)),
                                  child: CupertinoActivityIndicator())
                              : CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
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
                                  chat: chat)
                              .then((value) {
                            _controller.clear();
                            setState(() {
                              _isSending = false;
                            });
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
