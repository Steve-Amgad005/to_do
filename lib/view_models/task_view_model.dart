import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/repositories/task_repository.dart';
import '../models/model.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel(this.repository) {
    loadTasksOfflineFirst();
  }

  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  List<Task> get undonetasks => _tasks.where((t) => !t.completed).toList();
  List<Task> get finishedTasks => _tasks.where((t) => t.completed).toList();

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void loadTasks() {
    _tasks = repository.getTasks();
    notifyListeners();
  }

  /// Offline-first loader
  Future<void> loadTasksOfflineFirst() async {
    setLoading(true);

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // مفيش نت → اعمل load من local فقط
        _tasks = repository.getTasks();
      } else {
        // فيه نت → اعمل sync
        _tasks = await repository.syncTasks(""); // هنا حط التوكن الحقيقي لو موجود
      }
    } catch (e) {
      // لو حصل أي خطأ، ارجع للمحلي
      _tasks = repository.getTasks();
    }

    setLoading(false);
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

  void updateTask(Task task,
      {required String title,
        required String priority,
        required DateTime deadline}) {
    task.title = title;
    task.priority = priority;
    task.deadline = deadline;

    repository.updateTask(task);
    notifyListeners();
  }

  void toggleTaskDone(Task task) {
    task.completed = !task.completed;
    repository.updateTask(task);
    notifyListeners();
  }
}