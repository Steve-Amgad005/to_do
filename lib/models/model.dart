import 'package:flutter/material.dart';

class Task {
  String title;
  String priority;
  DateTime deadline;
  bool isDone;

  Task({
    required this.title,
    required this.priority,
    required this.deadline,
    this.isDone = false,
  });
}
