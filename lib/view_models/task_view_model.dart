import 'package:flutter/material.dart';

import '../data/repositories/task_repository.dart';
import '../models/model.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel(this.repository) {
    loadTasks();
  }

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get undonetasks => _tasks.where((t) => !t.isDone).toList();

  List<Task> get finishedTasks => _tasks.where((t) => t.isDone).toList();

  void loadTasks() {
    _tasks = repository.getTasks();
    notifyListeners();
  }

  void addTask(Task task) {
    repository.addTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    repository.deleteTask(task);
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(
      Task task, {
        required String title,
        required String priority,
        required DateTime deadline,
      }) {
    task.title = title;
    task.priority = priority;
    task.deadline = deadline;

    task.save(); // لو Hive
    notifyListeners();
  }

  void toggleTaskDone(Task task) {
    task.isDone = !task.isDone;
    repository.updateTask(task);
    notifyListeners();
  }
}
