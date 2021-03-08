import 'dart:io' as io;

import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:file/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:aunty_rafiki/models/user.dart' as userModel;

class PrivateMessageEditBar extends StatefulWidget {
  final LocalFileSystem localFileSystem;
  final Function onPressed;

  final String groupChatId;
  final userModel.User peer;

  const PrivateMessageEditBar(
      {Key key,
      this.onPressed,
      localFileSystem,
      @required this.groupChatId,
      @required this.peer})
      : this.localFileSystem = localFileSystem,
        super(key: key);

  @override
  _MessageEditBarState createState() => _MessageEditBarState(
      groupChatId: groupChatId, peer: peer, onPressed: onPressed);
}

class _MessageEditBarState extends State<PrivateMessageEditBar> {
  _MessageEditBarState({
    @required this.groupChatId,
    @required this.peer,
    @required this.onPressed,
  });
  FirebaseFirestore db;
  TextEditingController _controller;
  List<Asset> images = List<Asset>();
  bool _isSending = false;
  bool _isAudio = true;
  bool _showEmojiPicker = false;
  FocusNode focusNode;
  final userModel.User peer;
  final Function onPressed;

  String groupChatId;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);

    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6.0),
                child: Material(
                  elevation: 2,
                  color: Colors.white,
                  child: Column(
                    children: [
                      _chatProvider.messageToReply != null
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[100]),
                                color: Colors.grey[200],
                              ),
                              margin: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.pink,
                                        height: _chatProvider
                                                .messageToReply.media.isEmpty
                                            ? 60
                                            : 100,
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 4,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FirebaseAuth.instance
                                                            .currentUser.uid ==
                                                        _chatProvider
                                                            .messageToReply
                                                            .sender
                                                    ? 'You'
                                                    : '${_chatProvider.messageToReply.senderName}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                _chatProvider
                                                    .messageToReply.text,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      _chatProvider.messageToReply.media.isEmpty
                                          ? SizedBox(
                                              width: 20,
                                            )
                                          : Container(
                                              padding: const EdgeInsets.only(
                                                  right: 4, bottom: 2),
                                              child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: _chatProvider
                                                    .messageToReply.media[0],
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.pink,
                                        ),
                                        onTap: () {
                                          _chatProvider.setMessageToReply =
                                              null;
                                        }),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      Row(
                        children: [
                          IconButton(
                            icon: new Icon(_showEmojiPicker
                                ? Icons.keyboard
                                : Icons.face_retouching_natural),
                            onPressed: () {
                              setState(() {
                                _showEmojiPicker = !_showEmojiPicker;
                              });

                              if (_showEmojiPicker) {
                                dismissKeyboard();
                              } else {
                                showKeyboard();
                              }
                            },
                            color: Colors.black26,
                          ),
                          Container(
                            color: Colors.black26,
                            width: 2,
                            height: 35,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 20),
                              child: TextField(
                                focusNode: focusNode,
                                enabled: !_isSending,
                                controller: _controller,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 10,
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
                                      .onSendPrivateMessage(
                                    content: _controller.text,
                                    time: Timestamp.fromDate(DateTime.now()),
                                    senderId:
                                        FirebaseAuth.instance.currentUser.uid,
                                    groupChatId: groupChatId,
                                    peerId: peer.uid,
                                  )
                                      .then((value) {
                                    _controller.clear();
                                    setState(() {
                                      _isSending = false;
                                    });
                                    _chatProvider.scrollToBootomOfChats();
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type here...'),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: new Icon(Icons.attach_file),
                            onPressed: onPressed,
                            color: Colors.black26,
                          ),
                        ],
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
                        child: io.Platform.isIOS
                            ? Theme(
                                data: ThemeData(
                                    cupertinoOverrideTheme: CupertinoThemeData(
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
                          _showEmojiPicker = false;
                        });

                        _chatProvider
                            .onSendPrivateMessage(
                          content: _controller.text,
                          time: Timestamp.fromDate(DateTime.now()),
                          senderId: FirebaseAuth.instance.currentUser.uid,
                          groupChatId: groupChatId,
                          peerId: peer.uid,
                        )
                            .then((value) {
                          _controller.clear();
                          setState(() {
                            _isSending = false;
                          });
                          _chatProvider.scrollToBootomOfChats();
                        });
                      },
                color: Colors.white,
              ),
            ),
            SizedBox(width: 6),
          ],
        ),
        _showEmojiPicker
            ? EmojiPicker(
                rows: 3,
                columns: 7,
                buttonMode: ButtonMode.MATERIAL,
                recommendKeywords: ["racing", "horse"],
                numRecommended: 10,
                onEmojiSelected: (emoji, category) {
                  print(emoji.emoji);
                  _controller.text = _controller.text + emoji.emoji;
                  _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controller.text.length));
                },
              )
            : Container()
      ],
    );
  }

  void showKeyboard() {
    focusNode.requestFocus();
  }

  void dismissKeyboard() {
    focusNode.unfocus();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }
}
