import 'dart:io';

import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/components/cards/message_card.dart';
import 'package:aunty_rafiki/views/components/sheets/sticker_sheet.dart';
import 'package:aunty_rafiki/views/components/tiles/text_input_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    Future<bool> onBackPress() {
      if (_chatProvider.isShowSticker) {
        _chatProvider.getSticker();
      } else {
        Navigator.pop(context);
      }

      return Future.value(false);
    }

    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        leading: Platform.isAndroid
            ? null
            : FlatButton(
                child: Row(children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  _chatProvider.selectedChat.unreadMessageCounter == 0
                      ? Container()
                      : Expanded(
                        
                          child: Text(
                            
                              _chatProvider.selectedChat.unreadMessageCounter
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)))
                ]),
                onPressed: () => Navigator.pop(context)),
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(_chatProvider.selectedChat.avatar),
          ),
          title: Text(
            _chatProvider.selectedChat.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: _chatProvider.selectedChat.messages.length,
                  itemBuilder: (_, index) => MessageTile(
                        message: _chatProvider.selectedChat.messages[index],
                      )),
            ),

            // Sticker for us
            (_chatProvider.isShowSticker ? StickerSheet() : Container()),
            TextInputTile()
          ],
        ),
      ),
    );
  }
}
