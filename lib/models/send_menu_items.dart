import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SendMenuItems {
  String text;
  List<String> allowedExtensions;
  IconData icons;
  MaterialColor color;

  FileType fileType;
  SendMenuItems(
      {@required this.text,
      @required this.icons,
      @required this.allowedExtensions,
      @required this.fileType,
      @required this.color});
}

List<SendMenuItems> menuItems = [
  SendMenuItems(
      text: "Photos",
      fileType: FileType.image,
      icons: Icons.image,
      color: Colors.amber,
      allowedExtensions: null),
  SendMenuItems(
      text: "Documents",
      fileType: FileType.custom,
      icons: Icons.insert_drive_file,
      allowedExtensions: ['pdf', 'doc'],
      color: Colors.blue),
  SendMenuItems(
      text: "Audio",
      fileType: FileType.audio,
      icons: Icons.music_note,
      color: Colors.orange,
      allowedExtensions: null),
  SendMenuItems(
      text: "Video",
      icons: Icons.video_call,
      color: Colors.green,
      fileType: FileType.video,
      allowedExtensions: null),
  SendMenuItems(
      text: "Location",
      icons: Icons.location_on,
      color: Colors.green,
      fileType: FileType.any,
      allowedExtensions: null),

];
