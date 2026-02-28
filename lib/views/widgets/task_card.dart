import 'package:flutter/material.dart';
import 'package:to_do/models/model.dart';
import 'package:to_do/view_models/task_view_model.dart';
import 'package:to_do/views/home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:to_do/views/widgets/add_task_sheet.dart';

import 'edit_task_sheet.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Text("Options", style: TextStyle(color: Colors.white)),
                  content: Text("Choose an action", style: TextStyle(color: Colors.white70)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // close options dialog
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              title: Text("Alert", style: TextStyle(color: Colors.white)),
                              content: Text(
                                "Are you sure you want to delete this task?",
                                style: TextStyle(color: Colors.white70),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                    viewModel.removeTask(task);
                                  },
                                  child: Text("YES", style: TextStyle(color: Colors.yellow[700])),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(dialogContext).pop(),
                                  child: Text("NO", style: TextStyle(color: Colors.yellow[700])),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // close options dialog
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.black,
                          isScrollControlled: true,
                          builder: (_) => EditTaskSheet(task: task),
                        );
                      },
                      child: Text("Edit", style: TextStyle(color: Color(0xFFCAAF2D))),
                    ),
                  ],
                ),
              );

          },
          title: Text(
            task.title,
            style: TextStyle(
              color: Colors.white,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              decorationThickness: 3,
              decorationColor: Color(0xFFCAAF2D),
            ),
          ),
          subtitle: Text(
            task.priority,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            "${task.deadline.year}/${task.deadline.month}/${task.deadline.day}",
            style: const TextStyle(color: Colors.white),
          ),
          leading: Checkbox(
            checkColor: Color(0xFFCAAF2D),
            activeColor: Colors.grey[900],
            value: task.isDone,
            onChanged: (_) {
              // هنا بنحدث الحالة عن طريق الـ Provider
              context.read<TaskViewModel>().toggleTaskDone(task);
            },
          ),
        ),
      ),
    );
  }
}
