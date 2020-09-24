import 'package:flutter/material.dart';

class StickerSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //     type: 2,
                  //     sticker: 'assets/images/gif/mimi1.gif',
                  //     image: 'assets/images/gabriel.jpeg',
                  //     content: "mmhhh yesss",
                  //     idFrom: 10,
                  //     timestamp:
                  //         DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //     type: 2,
                  //     sticker: 'assets/images/gif/mimi2.gif',
                  //     image: 'assets/images/gabriel.jpeg',
                  //     content: "mmhhh yesss",
                  //     idFrom: 10,
                  //     timestamp:
                  //         DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //       type: 2,
                  //       sticker: 'assets/images/gif/mimi3.gif',
                  //       image: 'assets/images/gabriel.jpeg',
                  //       content: "mmhhh yesss",
                  //       idFrom: 10,
                  //       timestamp:
                  //           DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  //  saveMessage(
                  //       type: 2,
                  //       sticker: 'assets/images/gif/mimi4.gif',
                  //       image: 'assets/images/gabriel.jpeg',
                  //       content: "mmhhh yesss",
                  //       idFrom: 10,
                  //       timestamp:
                  //           DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //     type: 2,
                  //     sticker: 'assets/images/gif/mimi5.gif',
                  //     image: 'assets/images/gabriel.jpeg',
                  //     content: "mmhhh yesss",
                  //     idFrom: 10,
                  //     timestamp:
                  //         DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //     type: 2,
                  //     sticker: 'assets/images/gif/mimi6.gif',
                  //     image: 'assets/images/gabriel.jpeg',
                  //     content: "mmhhh yesss",
                  //     idFrom: 10,
                  //     timestamp:
                  //         DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //     type: 2,
                  //     sticker: 'assets/images/gif/mimi7.gif',
                  //     image: 'assets/images/gabriel.jpeg',
                  //     content: "mmhhh yesss",
                  //     idFrom: 10,
                  //     timestamp:
                  //         DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () {
                  //  saveMessage(
                  //       type: 2,
                  //       sticker: 'assets/images/gif/mimi8.gif',
                  //       image: 'assets/images/gabriel.jpeg',
                  //       content: "mmhhh yesss",
                  //       idFrom: 10,
                  //       timestamp:
                  //           DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () {
                  // saveMessage(
                  //       type: 2,
                  //       sticker: 'assets/images/gif/mimi9.gif',
                  //       image: 'assets/images/gabriel.jpeg',
                  //       content: "mmhhh yesss",
                  //       idFrom: 10,
                  //       timestamp:
                  //           DateTime.now().millisecondsSinceEpoch.toString());
                },
                child: new Image.asset(
                  'assets/images/gif/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }
}
