import 'package:flutter/material.dart';

class Message {
  final String text;
  final String image;
  final String sticker;
  final String type;
  final DateTime date;
  final String sender;
  final String phoneNumber;
  final String userName;
  final String chatUuid;
  final bool sentByMe;

  Message(
      {@required this.text,
      @required this.date,
      @required this.chatUuid,
      @required this.sentByMe,
      this.sender,
      this.image,
      this.sticker,
      @required this.type,
      @required this.phoneNumber,
      @required this.userName});
}
