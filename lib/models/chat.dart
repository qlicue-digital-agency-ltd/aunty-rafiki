import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';

class Chat {
  final String uuid;
  final String name;

  final int unreadMessageCounter;
  final DateTime date;
  final String chartType;
  final String avatar;
  List<Message> messages;

  Chat(
      {@required this.uuid,
      @required this.name,
      @required this.date,
      @required this.chartType,
      @required this.avatar,
      this.messages,
      @required this.unreadMessageCounter});
}

