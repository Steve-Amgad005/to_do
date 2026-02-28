import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // لتنسيق التاريخ
import 'package:provider/provider.dart';

import '../../models/model.dart';
import '../../view_models/task_view_model.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String selectedPriority = "low";
  DateTime selectedDate = DateTime.now(); //

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add Task", style: TextStyle(color: Colors.white, fontSize: 22)),
          SizedBox(height: 20),
          // عنوان المهمة
          TextField(
            controller: titleController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          // اختيار الأولوية
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
                          style: TextStyle(color: Colors.white),
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
          SizedBox(height: 20),
          TextField(
            controller: dateController,
            readOnly: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Select deadline",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.white),
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
                        // تحويل التاريخ لنص
                        dateController.text = DateFormat(
                          'yyyy/MM/dd',
                        ).format(selectedDate);
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFCAAF2D),
            ),
            onPressed: () {
              if (titleController.text.trim().isEmpty) {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: Text(
                          "Warning",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                          "Please enter task name",
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.yellow[700]),
                            ),
                          ),
                        ],
                      ),
                );
                return;
              }

              viewModel.addTask(
                Task(
                  title: titleController.text.trim(),
                  priority: selectedPriority,
                  deadline:
                      dateController.text.isEmpty
                          ? DateTime.now()
                          : selectedDate,
                ),
              );
              Navigator.pop(context);
            },
            child: Text("Add Task", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
