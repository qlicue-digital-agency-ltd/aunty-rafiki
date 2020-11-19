import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aunty_rafiki/models/tracker.dart';

class TrackerProvider extends ChangeNotifier {
  TrackerProvider() {
    fetchTrackers();
  }
  //variables...
  bool _isFetchingTrackerData = false;
  List<Tracker> _availableTrackers = [];

  // getters

  List<Tracker> get availableTrackers => _availableTrackers;

  bool get isFetchingTrackerData => _isFetchingTrackerData;

  Future<bool> fetchTrackers() async {
    bool hasError = true;
    _isFetchingTrackerData = true;
    notifyListeners();
    final Map<String, dynamic> _data = {"conception_date": conceptioDate};

    final List<Tracker> _fetchedTrackers = [];
    try {
      final http.Response response = await http.post(api + "trackers",
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        data['trackers'].forEach((trackerData) {
          final tracker = Tracker.fromMap(trackerData);
          _fetchedTrackers.add(tracker);
        });
        hasError = false;
      }

    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableTrackers = _fetchedTrackers;
    _isFetchingTrackerData = false;

    print(_availableTrackers.length);
    notifyListeners();

    return hasError;
  }

  set toogleTracker(int week) {
    _availableTrackers.forEach((tracker) {
      if (tracker.week == week) tracker.show = !tracker.show;
    });
    notifyListeners();
  }
}
