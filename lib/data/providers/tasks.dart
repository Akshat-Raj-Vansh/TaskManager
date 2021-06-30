//@dart=2.9

import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task.dart';
import 'package:taskmanager/data/models/user.dart';
import 'package:taskmanager/data/network_service.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];
  final User user;
  final NetworkService api;

  Tasks(this.user, this.api, this._tasks);

  List<Task> get tasks {
    return [..._tasks];
  }

  Future<void> fetchTasks() async {
    try {
      final tasksRaw = await api.fetchTask(user.token);
      _tasks = tasksRaw.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> createTask(Task task) async {
    try {
      Task newTask = await api.createTask(task, user.token);
      _tasks.add(newTask);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateTask(Task task) async {
    final taskIndex = _tasks.indexWhere((mtask) => mtask.id == task.id);
    try {
      _tasks[taskIndex] = await api.updateTask(task, user.token);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void deleteTask(Task task) async {
    final existingTaskIndex = _tasks.indexWhere((mtask) => mtask.id == task.id);
    var existingTask = _tasks[existingTaskIndex];
    _tasks.removeAt(existingTaskIndex);
    try {
      await api.deleteTask(task.id, user.token);
    } catch (error) {
      _tasks.insert(existingTaskIndex, existingTask);
      print(error);
    }
    notifyListeners();
    existingTask = null;
  }
}
