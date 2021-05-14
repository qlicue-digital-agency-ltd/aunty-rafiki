import 'dart:async';
import 'dart:io';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class MediaMessageEditBar extends StatefulWidget {
  final Function onPressed;
  final Chat chat;
  const MediaMessageEditBar({Key key, this.onPressed, @required this.chat})
      : super(key: key);

  @override
  _MediaMessageEditBarState createState() =>
      _MediaMessageEditBarState(chat: chat);
}

class _MediaMessageEditBarState extends State<MediaMessageEditBar> {
  FirebaseFirestore db;
  TextEditingController _controller;
  List<Asset> images = <Asset>[];
  bool _isSending = false;
  final Chat chat;

  _MediaMessageEditBarState({@required this.chat});

  ///check for internet connection
  String _connectionStatus = 'unknown';

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

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
    final _chatProvider = Provider.of<ChatProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
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
                          if (_connectionStatus == 'ConnectivityResult.none' ||
                              _connectionStatus == 'unknown') {
                            Fluttertoast.showToast(
                                msg: Languages.of(context)
                                    .labelNoItemTileInternet,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            if (chat != null) {
                              _chatProvider
                                  .sendMessage(
                                      text: _controller.text,
                                      time: Timestamp.fromDate(DateTime.now()),
                                      user:
                                          FirebaseAuth.instance.currentUser.uid,
                                      chat: chat,
                                      repliedMessage:
                                          _chatProvider.messageToReply,
                                      senderName:
                                          _authProvider.currentUser.displayName)
                                  .then((value) {
                                _controller.clear();
                                setState(() {
                                  _isSending = false;
                                });
                                Navigator.pop(context);
                              });
                            } else {
                              _chatProvider
                                  .onSendPrivateMessage(
                                      content: _controller.text,
                                      time: Timestamp.fromDate(DateTime.now()),
                                      groupChatId: _chatProvider.groupChatId,
                                      peerId: _chatProvider.peerId,
                                      senderId:
                                          FirebaseAuth.instance.currentUser.uid,
                                      repliedMessage:
                                          _chatProvider.privateMessageToReply)
                                  .then((value) {
                                _controller.clear();
                                setState(() {
                                  _isSending = false;
                                });
                                Navigator.pop(context);
                              });
                            }
                          }
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
                    if (_connectionStatus == 'ConnectivityResult.none' ||
                        _connectionStatus == 'unknown') {
                      Fluttertoast.showToast(
                          msg: Languages.of(context).labelNoItemTileInternet,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      setState(() {
                        _isSending = true;
                      });
                      if (chat != null) {
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
                          Navigator.pop(context);
                        });
                      } else {
                        _chatProvider
                            .onSendPrivateMessage(
                                content: _controller.text,
                                time: Timestamp.fromDate(DateTime.now()),
                                groupChatId: _chatProvider.groupChatId,
                                peerId: _chatProvider.peerId,
                                senderId: FirebaseAuth.instance.currentUser.uid,
                                repliedMessage:
                                    _chatProvider.privateMessageToReply)
                            .then((value) {
                          _controller.clear();
                          setState(() {
                            _isSending = false;
                          });
                          Navigator.pop(context);
                        });
                      }
                    }
                  },
            color: Colors.white,
          ),
        ),
        SizedBox(width: 6),
      ],
    );
  }
}
