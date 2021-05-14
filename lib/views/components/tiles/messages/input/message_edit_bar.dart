import 'dart:async';
import 'dart:io' as io;
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:file/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MessageEditBar extends StatefulWidget {
  final LocalFileSystem localFileSystem;
  final Function onPressed;

  const MessageEditBar({
    Key key,
    this.onPressed,
    localFileSystem,
  })  : this.localFileSystem = localFileSystem,
        super(key: key);

  @override
  _MessageEditBarState createState() => _MessageEditBarState();
}

class _MessageEditBarState extends State<MessageEditBar> {
  FirebaseFirestore db;
  TextEditingController _controller;
  List<Asset> images = <Asset>[];
  bool _isSending = false;
  // bool _isAudio = true;
  bool _showEmojiPicker = false;
  FocusNode focusNode;

  ///check for internet connection
  String _connectionStatus = 'unknown';

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
    focusNode = FocusNode();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'unknown');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Chat chat = Provider.of<Chat>(context);

    final _chatProvider = Provider.of<ChatProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
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
                                      // _isAudio = true;
                                    });
                                  } else {
                                    setState(() {
                                      // _isAudio = false;
                                    });
                                  }
                                },
                                onSubmitted: (text) {
                                  _chatProvider
                                      .sendMessage(
                                          text: _controller.text,
                                          time: Timestamp.fromDate(
                                              DateTime.now()),
                                          user: FirebaseAuth
                                              .instance.currentUser.uid,
                                          chat: chat,
                                          repliedMessage:
                                              _chatProvider.messageToReply,
                                          senderName: _authProvider
                                              .currentUser.displayName)
                                      .then((value) {
                                    _controller.clear();
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
                            onPressed: widget.onPressed,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // _isAudio
            //     ? Material(
            //         elevation: 2,
            //         shape: CircleBorder(),
            //         clipBehavior: Clip.antiAlias,
            //         color: Theme.of(context).primaryColor,
            //         child: IconButton(
            //           icon: _isSending
            //               ? Center(
            //                   child: io.Platform.isIOS
            //                       ? Theme(
            //                           data: ThemeData(
            //                               cupertinoOverrideTheme:
            //                                   CupertinoThemeData(
            //                                       brightness: Brightness.dark)),
            //                           child: CupertinoActivityIndicator())
            //                       : CircularProgressIndicator(
            //                           valueColor:
            //                               new AlwaysStoppedAnimation<Color>(
            //                                   Colors.white),
            //                         ))
            //               : Icon(Icons.mic),
            //           onPressed: () {},
            //           color: Colors.white,
            //         ),
            //       )
            //     :

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
                        if (_connectionStatus == 'ConnectivityResult.none' ||
                            _connectionStatus == 'unknown') {
                          Fluttertoast.showToast(
                              msg:
                                  Languages.of(context).labelNoItemTileInternet,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          setState(() {
                            _isSending = true;
                            _showEmojiPicker = false;
                          });

                          _chatProvider
                              .sendMessage(
                                  text: _controller.text,
                                  time: Timestamp.fromDate(DateTime.now()),
                                  user: FirebaseAuth.instance.currentUser.uid,
                                  chat: chat,
                                  repliedMessage: _chatProvider.messageToReply,
                                  senderName:
                                      _authProvider.currentUser.displayName)
                              .then((value) {
                            _controller.clear();
                            setState(() {
                              _isSending = false;
                            });
                            _chatProvider.scrollToBootomOfChats();
                          });
                        }
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
}
