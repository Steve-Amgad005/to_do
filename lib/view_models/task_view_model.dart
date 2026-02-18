import 'package:flutter/material.dart';
import '../models/model.dart';
import 'package:hive/hive.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  final Box box = Hive.box('tasksBox');

  TaskViewModel() {
    loadTasks();
  }

  void loadTasks() {
    final data = box.values.toList();

    _tasks =
        data.map((item) {
          return Task(
            title: item['title'],
            priority: item['priority'],
            deadline: DateTime.parse(item['deadline']),
            isDone: item['isDone'],
          );
        }).toList();

    notifyListeners();
  }

  List<Task> get tasks => _tasks;

  List<Task> get undonetasks => _tasks.where((t) => !t.isDone).toList();

  List<Task> get finishedTasks => _tasks.where((t) => t.isDone).toList();

  void addTask(Task task) {
    _tasks.add(task);

    box.add({
      'title': task.title,
      'priority': task.priority,
      'deadline': task.deadline.toIso8601String(),
      'isDone': task.isDone,
    });

    notifyListeners();
  }

  void removeTask(Task task) {
    int index = _tasks.indexOf(task);

    box.deleteAt(index);
    _tasks.removeAt(index);

    notifyListeners();
  }

  void toggleTaskDone(Task task) {
    int index = _tasks.indexOf(task);

    task.isDone = !task.isDone;

    box.putAt(index, {
      'title': task.title,
      'priority': task.priority,
      'deadline': task.deadline.toIso8601String(),
      'isDone': task.isDone,
    });

    notifyListeners();
  }

}
