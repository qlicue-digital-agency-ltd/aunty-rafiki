import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/sample/widgets/message/media_message_edit_bar.dart';
import 'package:aunty_rafiki/sample/widgets/message_edit_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
          child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Image.file(_chatProvider.pickedImage),
          MediaMessageEditBar()
        ],
      )),
    );
  }
}
