import 'package:hive/hive.dart';
import 'package:to_do/models/model.dart';

class TaskDataSource {
  final Box<Task> box = Hive.box<Task>('tasksBox');

  // جلب كل المهام
  List<Task> getAllTasks() {
    return box.values.toList();
  }

  // إضافة مهمة
  void addTask(Task task) {
    box.add(task);
  }

  // تحديث مهمة
  void updateTask(Task task) {
    task.save(); // كل Task HiveObject عنده save()
  }

  // حذف مهمة
  void deleteTask(Task task) {
    task.delete(); // كل Task HiveObject عنده delete()
  }
}
