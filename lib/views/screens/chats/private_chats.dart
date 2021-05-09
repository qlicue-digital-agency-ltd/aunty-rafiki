import 'dart:async';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/models/user.dart';
import 'package:aunty_rafiki/views/components/tiles/chat/loader_chart_card.dart';
import 'package:aunty_rafiki/views/components/tiles/chat/private_chart_card.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                    itemCount: 20,
                  );
                } else {
                  List<User> userList = snapshot.data;
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
                          itemBuilder: (context, index) =>
                              buildItem(context, userList[index]),
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

  Widget buildItem(BuildContext context, User peer) {
    if (peer.uid == currentUserId) {
      return Container();
    } else {
      return PrivateChartcard(
        peer: peer,
      );
    }
  }
}
