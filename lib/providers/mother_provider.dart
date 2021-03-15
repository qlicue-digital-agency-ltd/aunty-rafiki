import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/mother.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MotherProvider extends ChangeNotifier {
  MotherProvider() {
    fetchMothers();
  }

  //variables...
  bool _isFetchingMotherData = false;
  bool _isSubmittingData = false;
  List<Mother> _availableMothers = [];

  // getters

  List<Mother> get availableMothers => _availableMothers.reversed.toList();

  bool get isFetchingMotherData => _isFetchingMotherData;
  bool get isSubmittingData => _isSubmittingData;
  Future<bool> fetchMothers() async {
    bool hasError = true;
    _isFetchingMotherData = true;
    notifyListeners();

    final List<Mother> _fetchedMothers = [];
    try {
      final http.Response response = await http.get(
          api + "mothers/" + FirebaseAuth.instance.currentUser.uid,
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['mothers'].forEach((bloodData) {
          final blood = Mother.fromMap(bloodData);
          _fetchedMothers.add(blood);
        });
        hasError = false;
      }

      print(_fetchedMothers);
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableMothers = _fetchedMothers;
    _isFetchingMotherData = false;

    print(_availableMothers.length);
    notifyListeners();

    return hasError;
  }

  //post mother
  Future<bool> postMother() async {
    bool hasError = true;
    _isSubmittingData = true;

    notifyListeners();

    final Map<String, dynamic> _data = {
      "uid": FirebaseAuth.instance.currentUser.uid,
    };

    notifyListeners();

    try {
      final http.Response response = await http.post(api + "mother",
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final _mother = Mother.fromMap(data['mother']);
        _availableMothers.add(_mother);

        hasError = false;
      }
    } catch (error) {
      print('-----------+++++----------------');
      print(error);

      hasError = true;
    }

    print(_availableMothers.length);
    print("-----------------------------------");
    print(availableMothers.length);
    print("-----------------------------------");
    _isSubmittingData = false;
    notifyListeners();
    return hasError;
  }

  //post mother
  Future<bool> postPregnancy({
    @required String conceptionDate,
  }) async {
    bool hasError = true;
    _isSubmittingData = true;

    notifyListeners();

    final Map<String, dynamic> _data = {
      "uid": FirebaseAuth.instance.currentUser.uid,
      "first_day_of_your_last_period": conceptionDate,
    };

    notifyListeners();

    try {
      final http.Response response = await http.post(api + "pregnancy",
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        print('ayeeeee');
        hasError = false;
      }
    } catch (error) {
      print('-----------+++++----------------');
      print(error);

      hasError = true;
    }

    _isSubmittingData = false;
    notifyListeners();
    return hasError;
  }
}
