import 'package:flutter/material.dart';
import '../models/model.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
      title: "Buy groceries",
      priority: "medium",
      deadline: DateTime(2026,2,16),
      isDone: false,
    ),
    Task(
      title: "Complete Flutter project",
      priority: "high",
      deadline: DateTime(2026,2,17),
      isDone: false,
    ),
    Task(
      title: "Walk the dog",
      priority: "low",
      deadline: DateTime(2026,2,14),
      isDone: true,
    ),
    Task(
      title: "Read a book",
      priority: "low",
      deadline: DateTime(2026,2,20),
      isDone: true,
    ),
  ];

  // Getter للـ tasks كامل
  List<Task> get tasks => _tasks;

  List<Task> get undonetasks => _tasks.where((t) => !t.isDone).toList();
  List<Task> get finishedTasks => _tasks.where((t) => t.isDone).toList();

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void toggleTaskDone(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }
}
