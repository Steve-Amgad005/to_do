import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String priority;

  @HiveField(2)
  DateTime deadline;

  @HiveField(3)
  bool isDone;

  Task({
    required this.title,
    required this.priority,
    required this.deadline,
    this.isDone = false,
  });
}