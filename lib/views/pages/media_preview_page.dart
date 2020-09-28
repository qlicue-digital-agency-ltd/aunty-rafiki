import 'package:aunty_rafiki/models/media.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MediaPreviewPage extends StatelessWidget {
  final Media media;

  const MediaPreviewPage({Key key, @required this.media}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_chatProvider.selectedChat.name.toString()),
          Text(
            DateFormat('Hm').format(_chatProvider.selectedChat.date),
            style: TextStyle(fontSize: 12),
          )
        ]),
        actions: [
          IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Hero(
        tag: media.url,
        child: Image.asset(media.url),
      )),
    );
  }
}
