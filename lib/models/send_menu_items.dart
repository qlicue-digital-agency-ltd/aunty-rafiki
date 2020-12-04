import 'package:flutter/material.dart';

class SendMenuItems {
  String text;
  IconData icons;
  MaterialColor color;
  SendMenuItems(
      {@required this.text, @required this.icons, @required this.color});
}

List<SendMenuItems> menuItems = [
  SendMenuItems(
      text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
  SendMenuItems(
      text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
  SendMenuItems(text: "Audio", icons: Icons.music_note, color: Colors.orange),
  SendMenuItems(
      text: "Location", icons: Icons.location_on, color: Colors.green),
  SendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
];
