import 'package:hive/hive.dart';
import 'package:to_do/models/model.dart';

class TaskDataSource {
  final Box<Task> box = Hive.box<Task>('tasksBox');

  List<Task> getAllTasks() => box.values.toList();

  void addTask(Task task) => box.add(task);

  Future<void> updateTask(Task task) async {
    await task.save(); // HiveObject.save() بيرجع Future
  }
  void deleteTask(Task task) => task.delete();

  // مهام مش متزامنة بعد
  List<Task> getUnsyncedTasks() {
    return box.values.where((t) => !t.isSynced || t.isDeleted).toList();
  }

  // حذف نهائي
  Future<void> deletePermanently(Task task) async {
    await task.delete();
  }

  // دمج مع السيرفر
  Future<void> mergeWithServer(List<Task> serverTasks) async {
    // مسح كل local tasks اللي موجودة على السيرفر
    for (var task in serverTasks) {
      var localTask = box.values.firstWhere(
              (t) => t.id == task.id,
          orElse: () => task); // لو مش موجود ضيفه
      await box.put(localTask.key, task);
    }
  }
}