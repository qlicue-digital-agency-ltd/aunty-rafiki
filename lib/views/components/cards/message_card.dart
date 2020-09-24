import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Row(
        children: [
          message.sentByMe ? Spacer() : Container(),
          Material(
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          message.sender == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(message.phoneNumber),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(message.userName)
                                  ],
                                )
                              : Text(message.sender),
                          Text(message.text),
                          SizedBox(height: 14)
                        ])),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      message.date.toString(),
                      style: TextStyle(color: Colors.black38),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final Message message;

  MessageTile({@required this.message});

  @override
  Widget build(BuildContext context) {
    return message.sentByMe
        ? Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 24),
            alignment:
                message.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left:10),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: message.sentByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))
                      : BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                  color: Colors.white),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10,bottom:15.0),
                    child: Text(message.text,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w300)),
                  ), 

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      DateFormat('Hm').format(message.date),
                      style: TextStyle(color: Colors.black38),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: message.sentByMe ? 0 : 24,
                right: message.sentByMe ? 24 : 0),
            alignment:
                message.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: message.sentByMe
                  ? EdgeInsets.only(left: 30)
                  : EdgeInsets.only(right: 30),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: message.sentByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))
                      : BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                  color: Colors.white),
              child: Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (message.sender == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(message.phoneNumber),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(message.userName)
                                    ],
                                  )
                                : Text(message.sender)),
                            Text(message.text,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OverpassRegular',
                                    fontWeight: FontWeight.w300)),
                            SizedBox(height: 14)
                          ])),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      DateFormat('Hm').format(message.date),
                      style: TextStyle(color: Colors.black38),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
