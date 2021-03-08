import 'package:aunty_rafiki/models/send_menu_items.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/backgrounds/chat_background.dart';
import 'package:aunty_rafiki/views/components/app/private/private_chat_detail_page_app_bar.dart';
import 'package:aunty_rafiki/views/components/app/private/private_selected_chat_app_bar.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/input/private_edit_bar.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/lists/private_message_list.dart';
import 'package:aunty_rafiki/views/pages/upload_image_page.dart';
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
    void _showModal() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 6,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Container(
                        height: 4,
                        width: 50,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              _chatProvider
                                  .openFileExplorer(
                                      pickingType: menuItems[index].fileType,
                                      allowedExtensions:
                                          menuItems[index].allowedExtensions)
                                  .then((val) {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UploadImagePage(
                                              chat: null,
                                            )));
                              });

                              ///
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[index].color.shade50,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                menuItems[index].icons,
                                size: 20,
                                color: menuItems[index].color.shade400,
                              ),
                            ),
                            title: Text(menuItems[index].text),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          });
    }

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
                  onPressed: () {
                    ///Temporary solution.....
                    _chatProvider.setgroupChatId = groupChatId;
                    _chatProvider.setPeerId = peer.uid;
                    _showModal();
                  },
                  groupChatId: groupChatId,
                  peer: peer,
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
