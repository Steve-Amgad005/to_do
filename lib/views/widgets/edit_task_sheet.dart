import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/model.dart';
import '../../view_models/task_view_model.dart';

class EditTaskSheet extends StatefulWidget {
  final Task task;

  const EditTaskSheet({super.key, required this.task});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  late TextEditingController titleController;
  late TextEditingController dateController;

  late String selectedPriority;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task.title);
    dateController = TextEditingController(
      text: DateFormat('yyyy/MM/dd').format(widget.task.deadline),
    );

    selectedPriority = widget.task.priority;
    selectedDate = widget.task.deadline;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Edit Task",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 20),

          /// Title
          TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Priority
          DropdownButtonFormField<String>(
            value: selectedPriority,
            dropdownColor: Colors.grey[900],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            items:
                ["low", "medium", "high"]
                    .map(
                      (priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedPriority = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          /// Date
          TextField(
            controller: dateController,
            readOnly: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Select deadline",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.yellow[700]!,
                            onPrimary: Colors.black,
                            surface: Colors.grey[900]!,
                            onSurface: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.grey[900],
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                      dateController.text = DateFormat(
                        'yyyy/MM/dd',
                      ).format(selectedDate);
                    });
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Save Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFCAAF2D),
            ),
            onPressed: () {
              if (titleController.text.trim().isEmpty) {
                Navigator.pop(context);
                return;
              }

              viewModel.updateTask(
                widget.task,
                title: titleController.text.trim(),
                priority: selectedPriority,
                deadline: selectedDate,
              );

              Navigator.pop(context);
            },
            child: const Text("Save Changes", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
