import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskStorage extends ChangeNotifier {
  static late Box<TaskModel> _taskBox;

  static Future<void> init() async {
    _taskBox = await Hive.openBox<TaskModel>('tasks');
  }

  List<TaskModel> get tasks => _taskBox.values.toList();

  void addTask(TaskModel task) {
    _taskBox.add(task);
    notifyListeners();
  }

  void deleteTask(TaskModel task) {
    task.delete();
    notifyListeners();
  }

  void toggleTask(TaskModel task) {
    task.toggleDone();
    notifyListeners();
  }
}
