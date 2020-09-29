import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';

class Chat {
  final String uuid;
  final String name;

  final int unreadMessageCounter;
  final DateTime date;
  final String chatType;
  final String avatar;
  List<Message> messages;

  Chat(
      {@required this.uuid,
      @required this.name,
      @required this.date,
      @required this.chatType,
      @required this.avatar,
      this.messages,
      @required this.unreadMessageCounter});
}
