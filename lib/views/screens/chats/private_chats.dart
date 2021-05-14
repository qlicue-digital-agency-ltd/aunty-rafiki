import 'dart:async';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/user.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/chat/loader_chart_card.dart';
import 'package:aunty_rafiki/views/components/tiles/chat/private_chart_card.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PrivateChats extends StatefulWidget {
  final String currentUserId;

  const PrivateChats({Key key, @required this.currentUserId}) : super(key: key);
  @override
  _PrivateChatsState createState() =>
      _PrivateChatsState(currentUserId: currentUserId);
}

class _PrivateChatsState extends State<PrivateChats> {
  _PrivateChatsState({@required this.currentUserId});
  final String currentUserId;

  final ScrollController _listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  bool isLoading = false;
  bool isLoa = false;

  ///chech for internet connection
  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _listScrollController.addListener(scrollListener);
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

  void scrollListener() {
    if (_listScrollController.offset >=
            _listScrollController.position.maxScrollExtent &&
        !_listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  Future<bool> onBackPress() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          // List
          Container(
            child: StreamBuilder<List<User>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .limit(_limit)
                  .snapshots()
                  .map(firestoreToUserList),
              builder: (context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text('error: ${snapshot.error.toString()}'));
                }

                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) => LoaderChartcard(),
                    itemCount: 10,
                  );
                } else {
                  List<User> userList = snapshot.data;
                  userList.removeWhere((user) => user.uid == currentUserId);
                  return userList.isEmpty
                      ? Center(
                          child: (Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                            ),
                            _connectionStatus == 'unkwon'
                                ? NoItemTile(
                                    icon: 'assets/icons/no-wifi.png',
                                    title: Languages.of(context)
                                        .labelNoItemTileInternet,
                                    onTap: () {
                                      // _trackerProvider.fetchTrackers();
                                    },
                                  )
                                : _connectionStatus == 'ConnectivityResult.none'
                                    ? NoItemTile(
                                        icon: 'assets/icons/no-wifi.png',
                                        title: Languages.of(context)
                                            .labelNoItemTileInternet,
                                        onTap: () {
                                          // _trackerProvider.fetchTrackers();
                                        },
                                      )
                                    : NoItemTile(
                                        icon: 'assets/icons/chat.png',
                                        title: Languages.of(context)
                                            .labelNoItemTilePeers,
                                      ),
                          ],
                        )))
                      : ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: _authProvider.currentUser.chats
                                    .contains(userList[index].uid)
                                ? Container(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    color: _chatProvider.selectedUsers
                                            .containsKey(index)
                                        ? Colors.pink[50].withOpacity(0.5)
                                        : Colors.transparent,
                                    child: PrivateChartcard(
                                      peer: userList[index],
                                      onLongPress: () {
                                        setState(() {
                                          _chatProvider.selectContact(
                                              index: index,
                                              uid: userList[index].uid);
                                        });
                                      },
                                      isSelected: _chatProvider.selectedUsers
                                          .containsKey(index),
                                    ),
                                  )
                                : Center(
                                  child: Column(
                                    children: [
                                         SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                            ),
                                      NoItemTile(
                                              icon: 'assets/icons/chat.png',
                                              title: Languages.of(context)
                                                  .labelNoItemTilePeers,
                                            ),
                                    ],
                                  ),
                                ),
                          ),
                          itemCount: userList.length,
                          controller: _listScrollController,
                        );
                }
              },
            ),
          ),
        ],
      ),
      onWillPop: onBackPress,
    );
  }
}
