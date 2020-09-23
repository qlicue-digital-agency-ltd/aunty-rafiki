import 'package:flutter/material.dart';

class Message {
  final String text;
  final String time;
  final String sender;
  final String phoneNumber;
  final String userName;
  final String chatUuid;
  final bool ownedByme;

  Message(
      {@required this.text,
      @required this.time,
      @required this.chatUuid,
      @required this.ownedByme,
      this.sender,
      @required this.phoneNumber,
      @required this.userName});
}

List<Message> messagePool = <Message>[
  Message(
      text: 'Hello world today',
      time: 'Yesterday',
      chatUuid: 'YYUU90989',
      ownedByme: false,
      sender: 'Henry Victor',
      phoneNumber: '+29982222',
      userName: '~P-L'),
  Message(
      text: 'Hello world today',
      time: 'Yesterday',
      chatUuid: 'YYUU90989',
      ownedByme: false,
      phoneNumber: '+255715785672',
      userName: "~P-L😂"),
  Message(
      text: 'Hello world today',
      time: 'Yesterday',
      chatUuid: 'YYUU90989',
      ownedByme: false,
      sender: 'Mary Paul',
      phoneNumber: '+29982222',
      userName: '~K-L'),
  Message(
      text: 'Hello world today',
      time: 'Yesterday',
      chatUuid: 'YYUU90989',
      ownedByme: true,
      sender: 'James',
      phoneNumber: '+29982222',
      userName: '~R-D'),
];
