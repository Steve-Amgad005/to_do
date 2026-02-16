import 'package:flutter/material.dart';
import 'package:to_do/views/homepage.dart';
import 'package:provider/provider.dart';
import 'view_models/task_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskViewModel(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
