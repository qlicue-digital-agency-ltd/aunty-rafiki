import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/components/tiles/messages/input/media_message_edit_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImagePage extends StatelessWidget {
  final Chat chat;

  const UploadImagePage({Key key, @required this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: Stack(
          children: [
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(_chatProvider.files.length, (index) {
                return Container(
                  child: Image.file(_chatProvider.files[index]),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.black26,
                child: MediaMessageEditBar(
                  chat: chat,
                ),
              ),
            )
          ],
        )

        // Center(
        //     child: ListView(
        //   physics: NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   children: [

        //     Image.file(_chatProvider.files[0]),
        //     MediaMessageEditBar(
        //       chat: chat,
        //     )
        //   ],
        // )
        // ),
        );
  }
}
