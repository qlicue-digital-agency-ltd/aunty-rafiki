import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/letter_button.dart';
import 'package:aunty_rafiki/models/task.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TaskProvider with ChangeNotifier {
  TaskProvider() {
    _calendarTasks = {};

    _selectedCalendarTasks = _calendarTasks[_selectedCalendarDay] ?? [];
    fetchTasks();
  }

  //variables
  bool _isFetchingTaskData = false;
  DateTime _selectedCalendarDay = DateTime.now();

  Map<DateTime, List> _calendarTasks;
  List<Task> _availableTasks = [];
  List<Task> _filteredTasks = [];
  List<LetterButton> _availableLetterButton = letteButtonLists;
  List _selectedCalendarTasks = [];
  Task _selectedTask;

  //setters
  bool _isSubmittingData = false;
  set selectTask(Task task) {
    _selectedTask = task;
    notifyListeners();
  }

  set setCalendarDate(DateTime dateTime) {
    _selectedCalendarDay = dateTime;
    notifyListeners();
  }

  set selectCalendarTasks(List appoinments) {
    _selectedCalendarTasks = appoinments;
    notifyListeners();
  }

  //getters
  Task get seletectedTask => _selectedTask;
  List<Task> get availableTasks => _availableTasks;
  List<Task> get filteredTasks => _filteredTasks;

  List get selectedCalendarTasks => _selectedCalendarTasks;
  Map<DateTime, List> get calendarTasks => _calendarTasks;
  DateTime get selectedCalendarDay => _selectedCalendarDay;
  bool get isFetchingTaskData => _isFetchingTaskData;
  bool get isSubmittingData => _isSubmittingData;
  List<LetterButton> get availableLetterButton => _availableLetterButton;

  //fetch Tasks...
  Future<bool> fetchTasks() async {
    bool hasError = true;
    _isFetchingTaskData = true;
    notifyListeners();
    final List<Task> _fetchedTasks = [];
    try {
      final http.Response response = await http.get(Uri.parse(api + "tasks/1"),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['tasks'].forEach((taskData) {
          final _task = Task.fromMap(taskData);
          _fetchedTasks.add(_task);
        });
        hasError = false;
      }

      print(_fetchedTasks);
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableTasks = _fetchedTasks;
    _isFetchingTaskData = false;

    _availableTasks.forEach((task) {
      _updateCalenderTasks(task.date);
    });

    //filter all...
    filterTasks(_availableTasks, selectedLetterButton.tittle.toLowerCase());
    notifyListeners();

    return hasError;
  }

  //post task
  Future<bool> createTask(
      {@required name,
      @required stage,
      @required date,
      @required time,
      @required category,
      @required reminder}) async {
    bool hasError = true;
    _isSubmittingData = true;

    notifyListeners();
    final Map<String, dynamic> _data = {
      "name": name,
      "category": category,
      "stage": stage,
      "date": date,
      "time": time,
      "user_id": 1,
      "reminder": reminder
    };

    notifyListeners();

    try {
      final http.Response response = await http.post( Uri.parse(api + "task"),
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final _task = Task.fromMap(data['task']);
        _availableTasks.add(_task);

        _selectedCalendarTasks.add(_task);
        // _updateCalenderTasks(date);
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

  //update task
  _updateCalenderTasks(date) {
    final DateFormat _formatter = DateFormat('yyyy-MM-dd');
    _calendarTasks[DateTime.parse(date)] = _availableTasks
        .where((task) =>
            _formatter.format(DateTime.parse(task.date)) ==
            _formatter.format(DateTime.parse(date)))
        .toList();
    notifyListeners();
  }

  deletedAppoint(int index) {
    _availableTasks.removeAt(index);
    notifyListeners();
  }

  set toogleLetterButton(int id) {
    _availableLetterButton.forEach((letterButton) {
      if (letterButton.id == id) {
        letterButton.isSelected = true;
      } else {
        letterButton.isSelected = false;
      }
    });
    notifyListeners();

    //filter tasks....

    filterTasks(_availableTasks, selectedLetterButton.tittle.toLowerCase());
  }

  LetterButton get selectedLetterButton =>
      _availableLetterButton.where((button) => button.isSelected).first;

  filterTasks(List<Task> tasks, String category) {
    if (category == 'all') {
      _filteredTasks = _availableTasks;
    } else {
      _filteredTasks = tasks
          .where(
              (task) => task.category.toLowerCase() == category.toLowerCase())
          .toList();
    }

    print(_filteredTasks.length);
    notifyListeners();
  }
}
