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
  DateTime _selectedCalendarDay = DateTime.now();

  Map<DateTime, List> _calendarFoods;
  List<Food> _availableFoods = [];
  List _selectedCalendarFoods = [];
  Food _selectedFood;

  //setters
  bool _isSubmittingData = false;
  set selectFood(Food food) {
    _selectedFood = food;
    notifyListeners();
  }

  set setCalendarDate(DateTime dateTime) {
    _selectedCalendarDay = dateTime;
    notifyListeners();
  }

  set selectCalendarFoods(List appoinments) {
    _selectedCalendarFoods = appoinments;
    notifyListeners();
  }

  //getters
  Food get seletectedFood => _selectedFood;
  List<Food> get availableFoods => _availableFoods;

  List get selectedCalendarFoods => _selectedCalendarFoods;
  Map<DateTime, List> get calendarFoods => _calendarFoods;
  DateTime get selectedCalendarDay => _selectedCalendarDay;
  bool get isFetchingFoodData => _isFetchingFoodData;
  bool get isSubmittingData => _isSubmittingData;

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
        data['foods'].forEach((foodData) {
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

  deletedAppoint(int index) {
    _availableFoods.removeAt(index);
    notifyListeners();
  }
}
