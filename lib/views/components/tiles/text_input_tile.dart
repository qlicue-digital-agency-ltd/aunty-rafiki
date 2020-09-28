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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(
        children: [
          Flexible(
            child: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.face),
                    onPressed: () {
                      _chatProvider.getSticker();
                    },
                    color: Theme.of(context).primaryColor,
                  ),

                  // Edit text
                  Flexible(
                    child: Container(
                      child: TextField(
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.0),
                        controller: textEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        focusNode: focusNode,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: new Icon(Icons.image),
                    onPressed: () {
                      _chatProvider.getSticker();
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    icon: new Icon(Icons.attach_file),
                    onPressed: () {
                      _chatProvider.getSticker();
                    },
                    color: Theme.of(context).primaryColor,
                  ),

                  // Button send message
                  // Material(
                  //   child: new Container(
                  //     margin: new EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: new IconButton(
                  //         icon: new Icon(Icons.send),
                  //         onPressed: () {
                  //           if (textEditingController.text.isNotEmpty) {
                  //             _chatProvider.sendMessage(
                  //                 text: textEditingController.text, type: 'text');
                  //             //  saveMessage(
                  //             //       type: 0,
                  //             //       sticker: 'assets/img/gif/mimi9.gif',
                  //             //       image: 'assets/img/gabriel.jpeg',
                  //             //       content: textEditingController.text,
                  //             //       idFrom: 10,
                  //             //       timestamp:
                  //             //           DateTime.now().millisecondsSinceEpoch.toString());
                  //             textEditingController.clear();
                  //           }
                  //         },
                  //         color: Theme.of(context).primaryColor),
                  //   ),
                  //   color: Colors.white,
                  // ),
                ],
              ),
              width: double.infinity,
              height: 50.0,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  // border:
                  //     new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
                  color: Colors.white),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {},
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                shape: BoxShape.circle
                  ),
              
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                
              ),
            ),
          )
        ],
      ),
    );
  }
}
