import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {

  @HiveField(0)
  String? id; // id بتاع السيرفر (_id)

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String priority;

  @HiveField(4)
  DateTime deadline;

  @HiveField(5)
  bool completed;

  @HiveField(6)
  bool isSynced; // هل مرفوع للسيرفر؟

  @HiveField(7)
  bool isDeleted; // اتعمله delete ولسه مترفعش؟

  @HiveField(8)
  DateTime updatedAt; // مهم لحل التعارضات


  Task({
    this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.deadline,
    this.completed = false,
    this.isSynced = false,
    this.isDeleted = false,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      priority: json['priority'] ?? 'medium',
      deadline: DateTime.parse(json['deadline']),
      isDeleted: false,
      isSynced: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'priority': priority,
      'deadline': deadline.toIso8601String(),
    };
  }
}