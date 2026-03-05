import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/model.dart';
import 'package:to_do/view_models/task_view_model.dart';
import 'package:to_do/views/widgets/add_task_sheet.dart';
import 'package:to_do/views/widgets/task_card.dart';

import '../../view_models/auth_view_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _syncOnStart();
  }
  Future<void> _syncOnStart() async {
    final token = "your_user_token"; // حط التوكن هنا
    final viewModel = context.read<TaskViewModel>();
    await viewModel.loadTasksOfflineFirst();
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);

    // فلترة المهام حسب البحث
    List<Task> filteredUndone =
        viewModel.undonetasks
            .where(
              (task) =>
                  task.title.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    List<Task> filteredFinished =
        viewModel.finishedTasks
            .where(
              (task) =>
                  task.title.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            final authVM = context.read<AuthViewModel>();

            await authVM.logout();

            Navigator.pushNamedAndRemoveUntil(
              context,
              "login",
              (route) => false,
            );
          },
        ),

        centerTitle: true,
        backgroundColor: Colors.black,
        title: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text("<<To Do>>"),
        ),
        titleTextStyle: TextStyle(
          color: Color(0xFFCAAF2D),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              if (value == "date") {
                viewModel.tasks.sort(
                  (a, b) => a.deadline.compareTo(b.deadline),
                );
              } else if (value == "priority") {
                Map<String, int> priorityOrder = {
                  "high": 3,
                  "medium": 2,
                  "low": 1,
                };
                viewModel.tasks.sort(
                  (a, b) => priorityOrder[b.priority]!.compareTo(
                    priorityOrder[a.priority]!,
                  ),
                );
              }
              viewModel.notifyListeners(); // لتحديث الـ UI بعد الـ sort
            },
            color: Colors.grey[900],
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: "date",
                    child: Text(
                      "Sort by date",
                      style: TextStyle(color: Color(0xFFCAAF2D)),
                    ),
                  ),
                  PopupMenuItem(
                    value: "priority",
                    child: Text(
                      "Sort by priority",
                      style: TextStyle(color: Color(0xFFCAAF2D)),
                    ),
                  ),
                ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value; // تحديث البحث تلقائيًا
                  });
                },
                style: TextStyle(
                  color: Colors.white, // لون الكلام اللي المستخدم يكتبه
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey[600], // لون النص الرمادي قبل الكتابة
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(4),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    builder: (context) => const AddTaskSheet(),
                  );
                },
                icon: Icon(Icons.add_task),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      /////////////////////////////////////////////////////////////////////////////
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان المهام غير المنجزة
            Text(
              "Undone Tasks",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // ListView للمهام غير المنجزة
            Expanded(
              child:
                  filteredUndone.isEmpty
                      ? Center(
                        child: Text(
                          "No undone tasks",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                      : ListView.builder(
                        itemCount: filteredUndone.length,
                        itemBuilder: (context, index) {
                          final task = filteredUndone[index];
                          return TaskCard(task: task);
                        },
                      ),
            ),
            SizedBox(height: 20),
            // عنوان المهام المنجزة
            Text(
              "Finished Tasks",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // ListView للمهام المنجزة
            Expanded(
              child:
                  filteredFinished.isEmpty
                      ? Center(
                        child: Text(
                          "No finished tasks",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                      : ListView.builder(
                        itemCount: filteredFinished.length,
                        itemBuilder: (context, index) {
                          final task = filteredFinished[index];
                          return TaskCard(task: task);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
