import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/model.dart';

class RemoteTaskDataSource {
  final String baseUrl;

  RemoteTaskDataSource({required this.baseUrl});

  Future<List<Task>> getAllTasks(String token) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/todos'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final data = jsonDecode(res.body) as List;
    return data.map((t) => Task.fromJson(t)).toList();
  }

  Future<Map<String, dynamic>> createTask(String token, Task task) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(task.toJson()),
    );
    return jsonDecode(res.body);
  }

  Future<void> updateTask(String token, Task task) async {
    await http.put(
      Uri.parse('$baseUrl/api/todos/${task.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(task.toJson()),
    );
  }

  Future<void> deleteTask(String token, String id) async {
    await http.delete(
      Uri.parse('$baseUrl/api/todos/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}