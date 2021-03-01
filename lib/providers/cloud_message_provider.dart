import 'package:flutter/material.dart';

class CloudMessageProvider with ChangeNotifier {
  ///constructor..
  CloudMessageProvider() {}

  ///variables
  dynamic _data, _notification;

  ///gettters..
  dynamic get data => _data;
  dynamic get notification => _notification;

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      _data = message['data'];
      notifyListeners();
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      _notification = message['notification'];
      notifyListeners();
    }

    // Or do other work.
  }
}
