import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
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

  List get selectedCalendarTasks => _selectedCalendarTasks;
  Map<DateTime, List> get calendarTasks => _calendarTasks;
  DateTime get selectedCalendarDay => _selectedCalendarDay;
  bool get isFetchingTaskData => _isFetchingTaskData;
  bool get isSubmittingData => _isSubmittingData;

  //fetch Tasks...
  Future<bool> fetchTasks() async {
    bool hasError = true;
    _isFetchingTaskData = true;
    notifyListeners();
    final List<Task> _fetchedTasks = [];
    try {
      final http.Response response = await http
          .get(api + "tasks/1", headers: {'Content-Type': 'application/json'});

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
      final http.Response response = await http.post(api + "task",
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final _task = Task.fromMap(data['task']);
        _availableTasks.add(_task);

        _selectedCalendarTasks.add(_task);
        _updateCalenderTasks(date);
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
}
