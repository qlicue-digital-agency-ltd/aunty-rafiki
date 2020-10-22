import 'package:aunty_rafiki/sample/model/chat.dart';
import 'package:aunty_rafiki/views/backgrounds/background.dart';
import 'package:aunty_rafiki/sample/widgets/message_edit_bar.dart';
import 'package:aunty_rafiki/sample/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatelessWidget {
  ChatRoomPage();

  @override
  Widget build(BuildContext context) {
    Chat chat = ModalRoute.of(context).settings.arguments;
    return Provider<Chat>.value(
      value: chat,
      child: Scaffold(
        appBar: AppBar(title: Text(chat.name)),
        body: Stack(
          children: <Widget>[
            ChatBackground(),
            Column(
              children: <Widget>[
                Expanded(child: MessageList()),
                MessageEditBar()
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:io';

// import 'package:aunty_rafiki/providers/chat_provider.dart';
// import 'package:aunty_rafiki/views/components/tiles/message_tile.dart';
// import 'package:aunty_rafiki/views/components/sheets/sticker_sheet.dart';
// import 'package:aunty_rafiki/views/components/tiles/text_input_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatRoomPage extends StatefulWidget {
//   @override
//   _ChatRoomPageState createState() => _ChatRoomPageState();
// }

// class _ChatRoomPageState extends State<ChatRoomPage> {

//   Stream documentStream = FirebaseFirestore.instance.collection('chats').doc('1S5RzZBSmawNWlCjC4gF').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     final _chatProvider = Provider.of<ChatProvider>(context);
//     Future<bool> onBackPress() {
//       if (_chatProvider.isShowSticker) {
//         _chatProvider.getSticker();
//       } else {
//         Navigator.pop(context);
//       }

//       return Future.value(false);
//     }

//     return Scaffold(
//       backgroundColor: Color(0xfff7f7f7),
//       appBar: AppBar(
//         leading: Platform.isAndroid
//             ? null
//             : FlatButton(
//                 child: Row(children: <Widget>[
//                   Expanded(
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   _chatProvider.selectedChat.unreadMessageCounter == 0
//                       ? Container()
//                       : Expanded(
//                           child: Text(
//                               _chatProvider.selectedChat.unreadMessageCounter
//                                   .toString(),
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 18)))
//                 ]),
//                 onPressed: () => Navigator.pop(context)),
//         title: ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage(_chatProvider.selectedChat.avatar),
//           ),
//           title: Text(
//             _chatProvider.selectedChat.name,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: WillPopScope(
//         onWillPop: onBackPress,
//         child: Column(
//           children: [
//             Flexible(
//               child: ListView.builder(
//                   itemCount: _chatProvider.selectedChat.messages.length,
//                   itemBuilder: (_, index) => MessageTile(
//                         chatType: _chatProvider.selectedChat.chatType,
//                         message: _chatProvider.selectedChat.messages[index],
//                       )),
//             ),

//             // Sticker for us
//             (_chatProvider.isShowSticker ? StickerSheet() : Container()),
//             TextInputTile(),
//           ],
//         ),
//       ),
//     );
//   }
// }
