import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextInputTile extends StatelessWidget {
  final TextEditingController textEditingController =
      new TextEditingController();
  final FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: () {
                  _chatProvider.getSticker();
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      _chatProvider.sendMessage(
                          text: textEditingController.text, type: 'text');
                      //  saveMessage(
                      //       type: 0,
                      //       sticker: 'assets/img/gif/mimi9.gif',
                      //       image: 'assets/img/gabriel.jpeg',
                      //       content: textEditingController.text,
                      //       idFrom: 10,
                      //       timestamp:
                      //           DateTime.now().millisecondsSinceEpoch.toString());
                      textEditingController.clear();
                    }
                  },
                  color: Theme.of(context).primaryColor),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }
}
