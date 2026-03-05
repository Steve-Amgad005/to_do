import '../data_sources/remote_task_data_source.dart';
import '../data_sources/task_data_source.dart';
import '../../models/model.dart';

class TaskRepository {
  final TaskDataSource local;
  final RemoteTaskDataSource remote;

  TaskRepository({required this.local, required this.remote});

  List<Task> getTasks() => local.getAllTasks();
  void addTask(Task task) => local.addTask(task);
  void updateTask(Task task) => local.updateTask(task);
  void deleteTask(Task task) => local.deleteTask(task);

  Future<List<Task>> syncTasks(String token) async {
    final unsyncedTasks = local.getUnsyncedTasks();

    for (var task in unsyncedTasks) {
      if (task.isDeleted) {
        if (task.id != null) await remote.deleteTask(token, task.id!);
        await local.deletePermanently(task);
        continue;
      }

      if (task.id == null) {
        final result = await remote.createTask(token, task);
        task.id = result["_id"];
      } else {
        await remote.updateTask(token, task);
      }

      task.isSynced = true;
      task.updatedAt = DateTime.now();
      await local.updateTask(task);
    }

    final serverTasks = await remote.getAllTasks(token);
    await local.mergeWithServer(serverTasks);

    return local.getAllTasks();
  }
}