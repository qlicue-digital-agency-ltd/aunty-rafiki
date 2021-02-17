import 'package:aunty_rafiki/models/send_menu_items.dart';
import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/backgrounds/chat_background.dart';
import 'package:aunty_rafiki/views/components/app/selected_chat_app_bar.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/input/message_edit_bar.dart';

import 'package:aunty_rafiki/views/components/tiles/messages/message_list.dart';
import 'package:aunty_rafiki/views/components/app/chat_detail_page_app_bar.dart';
import 'package:aunty_rafiki/views/pages/upload_image_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {


  @override
  Widget build(BuildContext context) {
    Chat chat = ModalRoute.of(context).settings.arguments;
    final _chatProvider = Provider.of<ChatProvider>(context);

    void showModal(Chat chat) {
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
                                              chat: chat,
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

    return Provider<Chat>.value(
      value: chat,
      child: Scaffold(
        appBar: _chatProvider.selectedMessages.isEmpty
            ? ChatDetailPageAppBar(
                chat: chat,
              )
            : SelectedChatAppBar(
                chat: chat,
                listMessage: _chatProvider.selectedMessages,
              ),
        body: Stack(
          children: <Widget>[
            ChatBackground(),
            Column(
              children: <Widget>[
                MessageList(
                 
                ),
                MessageEditBar(
                  onPressed: () {
                    showModal(chat);
                    
                    
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
