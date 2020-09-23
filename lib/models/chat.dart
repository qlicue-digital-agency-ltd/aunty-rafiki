import 'package:flutter/material.dart';

class Chat {
  final String uuid;
  final String name;
  final String lastMessage;
  final int messageCounter;

  final String time;
  final String chartType;
  final String avatar;

  Chat(
      {@required this.uuid,
      @required this.name,
      @required this.lastMessage,
      @required this.time,
      @required this.chartType,
      @required this.avatar,
      @required this.messageCounter});
}

List<Chat> chatList = <Chat>[
  Chat(
      avatar: 'assets/images/a.jpg',
      lastMessage: 'Hello world',
      name: 'Matias',
      time: '12:30',
      uuid: 'YYUU90989',
      messageCounter: 0,
      chartType: 'private'),
  Chat(
      avatar: 'assets/images/b.jpg',
      lastMessage: 'Hello world',
      name: 'Goup Soccer',
      time: 'Yesterday',
      uuid: 'YYUU90989',
      messageCounter: 2,
      chartType: 'group'),
  Chat(
      avatar: 'assets/images/c.jpeg',
      lastMessage: 'Hello iisoais world',
      name: 'Marry',
      time: 'Sunday',
      uuid: 'YYUU90989',
      messageCounter: 10,
      chartType: 'private'),
  Chat(
      avatar: 'assets/images/d.jpeg',
      lastMessage: 'Hellohsjas world',
      name: 'Family',
      time: '12:30',
      uuid: 'YYUU90989',
      messageCounter: 0,
      chartType: 'group'),
  Chat(
      avatar: 'assets/images/a.jpg',
      lastMessage: 'Hello world',
      name: 'Peter',
      time: '12:30',
      uuid: 'YYUU90989',
      chartType: 'private',
      messageCounter: 3,)
];
