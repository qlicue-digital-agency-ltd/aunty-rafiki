import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/backgrounds/chat_background.dart';
import 'package:aunty_rafiki/views/components/app/private/private_chat_detail_page_app_bar.dart';
import 'package:aunty_rafiki/views/components/app/private/private_selected_chat_app_bar.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/input/private_edit_bar.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/lists/private_message_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aunty_rafiki/models/user.dart' as userModel;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PrivateChatRoomPage extends StatefulWidget {
  final userModel.User peer;

  const PrivateChatRoomPage({
    Key key,
    @required this.peer,
  }) : super(key: key);

  @override
  _PrivateChatRoomPageState createState() =>
      _PrivateChatRoomPageState(peer: peer);
}

class _PrivateChatRoomPageState extends State<PrivateChatRoomPage> {
  _PrivateChatRoomPageState({
    @required this.peer,
  });
  userModel.User peer;

  String id;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);

  String groupChatId;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(onFocusChange);

    groupChatId = '';

    readLocal();
  }

  void onFocusChange() {
    if (_focusNode.hasFocus) {
      // Hide sticker when keyboard appear

    }
  }

  readLocal() async {
    id = FirebaseAuth.instance.currentUser.uid;
    if (id.hashCode <= peer.uid.hashCode) {
      groupChatId = '$id-${peer.uid}';
    } else {
      groupChatId = '${peer.uid}-$id';
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': peer.uid});
  }

  Future<bool> onBackPress() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': null});
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: _chatProvider.selectedMessages.isEmpty
          ? PrivateChatDetailPageAppBar(
              peer: peer,
            )
          : PrivateSelectedChatAppBar(
              peer: peer,
              listMessage: _chatProvider.selectedMessages,
            ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            ChatBackground(),
            Column(
              children: <Widget>[
                // List of messages
                PrivateMessageList(
                  groupChatId: groupChatId,
                ),

                // Input content
                PrivateMessageEditBar(
                  onPressed: () {},
                  groupChatId: groupChatId, peer: peer,
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }
}
