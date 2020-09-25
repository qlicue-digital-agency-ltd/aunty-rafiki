import 'package:flutter/material.dart';

class Message {
  final String text;
  List<String> media;
  final String sticker;

  final DateTime date;
  final String sender;
  final String phoneNumber;
  final String userName;
  final String chatUuid;
  final bool sentByMe;

  Message(
      {this.text,
      @required this.date,
      @required this.chatUuid,
      @required this.sentByMe,
      this.sender,
      this.media,
      this.sticker,
 
      @required this.phoneNumber,
      @required this.userName});
}
