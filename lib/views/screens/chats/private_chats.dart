import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/tiles/private_chart_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final ScrollController _listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _listScrollController.addListener(scrollListener);
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .limit(_limit)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        buildItem(context, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    controller: _listScrollController,
                  );
                }
              },
            ),
          ),

          // Loading
          Positioned(
            child: isLoading ? const Loading() : Container(),
          )
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document.data()['id'] == currentUserId) {
      return Container();
    } else {
      return PrivateChartcard(
        document: document,
      );
    }
  }
}
