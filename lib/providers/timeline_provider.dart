import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/time_line.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TimelineProvider extends ChangeNotifier {
  TimelineProvider() {
    fetchTimelines();
  }
  //variables...
  bool _isFetchingTimelineData = false;
  List<Timeline> _availableTimelines = [];

  // getters

  List<Timeline> get availableTimelines => _availableTimelines;

  bool get isFetchingTimelineData => _isFetchingTimelineData;

  Future<bool> fetchTimelines() async {
    bool hasError = true;
    _isFetchingTimelineData = true;
    notifyListeners();
    

    final List<Timeline> _fetchedTimelines = [];
    try {
      final http.Response response = await http.get(api + "timelines",
         
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['timelines'].forEach((timelineData) {
          final timeline = Timeline.fromMap(timelineData);
          _fetchedTimelines.add(timeline);
        });
        hasError = false;
      }
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableTimelines = _fetchedTimelines;
    _isFetchingTimelineData = false;

    print(_availableTimelines.length);
    notifyListeners();

    return hasError;
  }
}
