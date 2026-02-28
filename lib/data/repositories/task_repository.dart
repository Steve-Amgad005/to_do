import '../data_sources/task_data_source.dart';
import '../../models/model.dart';

class TaskRepository {
  final TaskDataSource dataSource;

  TaskRepository(this.dataSource);

  List<Task> getTasks() => dataSource.getAllTasks();
  void addTask(Task task) => dataSource.addTask(task);
  void updateTask(Task task) => dataSource.updateTask(task);
  void deleteTask(Task task) => dataSource.deleteTask(task);
}