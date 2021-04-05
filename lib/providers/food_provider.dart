import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodProvider with ChangeNotifier {
  FoodProvider() {
    fetchFoods();
  }

  //variables
  bool _isFetchingFoodData = false;

  List<Food> _availableFoods = [];
 
  //setters

  //getters
  List<Food> get availableFoods => _availableFoods;
  bool get isFetchingFoodData => _isFetchingFoodData;

  //fetch Foods...
  Future<bool> fetchFoods() async {
    bool hasError = true;
    _isFetchingFoodData = true;
    notifyListeners();

    final List<Food> _fetchedFoods = [];
    try {
      final http.Response response = await http
          .get(api + "foods", headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['data'].forEach((foodData) {
          final _food = Food.fromMap(foodData);
          _fetchedFoods.add(_food);
        });
        hasError = false;
      }

      print(_fetchedFoods);
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableFoods = _fetchedFoods;
    _isFetchingFoodData = false;
    notifyListeners();
    return hasError;
  }


}
