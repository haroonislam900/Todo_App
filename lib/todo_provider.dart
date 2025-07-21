import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  List<Map<String, String>> _tasks = [];
  List<Map<String, String>> _filteredtasks = [];

  List<Map<String, String>> get tasks => _filteredtasks;

  TodoProvider() {
    _filteredtasks = List.from(_tasks);
  }

  void Addtask(String title, String description) {
    _tasks.add({'title': title, 'description': description});
    _filteredtasks = List.from(_tasks);
    //saveTaskToPrefs();
    notifyListeners();
  }

  void updateTask(int index, String newTitle, String newDescription) {
    _tasks[index] = {'title': newTitle, "description": newDescription};
    _filteredtasks = List.from(_tasks);
    //saveTaskToPrefs();
    notifyListeners();
  }

  void deletetask(int index) {
    _tasks.removeAt(index);
    _filteredtasks = List.from(_tasks);
    //saveTaskToPrefs();
    notifyListeners();
  }

  void cleartasks() {
    _tasks.clear();
    _filteredtasks.clear();
    //saveTaskToPrefs();
    notifyListeners();
  }

  void searchtasks(String query) {
    if (query.trim().isEmpty) {
      _filteredtasks = List.from(_tasks);
    } else {
      _filteredtasks = _tasks
          .where(
            (task) =>
                task['title']!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  Future<void> savetasktosharedprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(_tasks);
    prefs.setString('task_list', encoded);
  }

  Future<void> loadtaskfromsharedprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("task_list");
    if (data != null) {
      _tasks = List<Map<String, String>>.from(jsonDecode(data));
      _filteredtasks = List.from(_tasks);
      notifyListeners();
    }
  }
}
