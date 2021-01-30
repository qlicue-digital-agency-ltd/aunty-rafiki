import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aunty_rafiki/models/blood.dart';

class BloodLevelProvider extends ChangeNotifier {
  BloodLevelProvider() {
    fetchBloodLevels();
  }

  //variables...
  bool _isFetchingBloodLevelData = false;
  bool _isSubmittingData = false;
  List<Blood> _availableBloodLevels = [];

  // getters

  List<Blood> get availableBloodLevels =>
      _availableBloodLevels.reversed.toList();

  bool get isFetchingBloodLevelData => _isFetchingBloodLevelData;
  bool get isSubmittingData => _isSubmittingData;
  Future<bool> fetchBloodLevels() async {
    bool hasError = true;
    _isFetchingBloodLevelData = true;
    notifyListeners();

    final List<Blood> _fetchedBloodLevels = [];
    try {
      final http.Response response = await http.get(
          api + "bloodlevels/" + FirebaseAuth.instance.currentUser.uid,
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['bloodlevels'].forEach((bloodData) {
          final blood = Blood.fromMap(bloodData);
          _fetchedBloodLevels.add(blood);
        });
        hasError = false;
      }

      print(_fetchedBloodLevels);
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableBloodLevels = _fetchedBloodLevels;
    _isFetchingBloodLevelData = false;

    print(_availableBloodLevels.length);
    notifyListeners();

    return hasError;
  }

  //post bloodLevel
  Future<bool> postBloodLevel({
    @required double quantity,
    @required date,
  }) async {
    bool hasError = true;
    _isSubmittingData = true;

    notifyListeners();


    final Map<String, dynamic> _data = {
      "quantity": quantity,
      "level": quantity >= 12 ? 'normal' : 'low',
      "status": quantity >= 12
          ? bloodLevelMessage[1].status
          : bloodLevelMessage[0].status,
      "title": quantity >= 12
          ? bloodLevelMessage[1].title
          : bloodLevelMessage[0].title,
      "subtitle": quantity >= 12
          ? bloodLevelMessage[1].subtitle
          : bloodLevelMessage[0].subtitle,
      "uid": FirebaseAuth.instance.currentUser.uid,
      "date": date
    };

    notifyListeners();

    try {
      final http.Response response = await http.post(api + "bloodlevel",
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final _bloodLevel = Blood.fromMap(data['bloodlevel']);
        _availableBloodLevels.add(_bloodLevel);

        hasError = false;
      }
    } catch (error) {
      print('-----------+++++----------------');
      print(error);

      hasError = true;
    }

    print(_availableBloodLevels.length);
    print("-----------------------------------");
    print(availableBloodLevels.length);
    print("-----------------------------------");
    _isSubmittingData = false;
    notifyListeners();
    return hasError;
  }

  static final bloodLevelMessage = <BloodLevelMessage>[
    BloodLevelMessage(
        quantity: 0,
        status: "veryLow",
        subtitle: "Your blood level is low you have to take suppliments",
        title: "Very Low"),
    BloodLevelMessage(
        quantity: 0,
        status: "normal",
        subtitle: "Your blood level is normal, continue taking suppliments",
        title: "Normal"),
  ];
}

class BloodLevelMessage {
  final double quantity;
  final String title;
  final String subtitle;
  final String status;

  BloodLevelMessage(
      {@required this.quantity,
      @required this.title,
      @required this.subtitle,
      @required this.status});
}
