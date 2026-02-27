import 'package:flutter/material.dart';
import 'package:to_do/view_models/auth_view_model.dart';
import 'package:to_do/views/auth/login.dart';
import 'package:to_do/views/auth/register.dart';
import 'package:to_do/views/homepage.dart';
import 'package:provider/provider.dart';
import 'view_models/task_view_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('tasksBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        "home": (context) => Homepage(),
        "login": (context) => LoginPage(),
        "register": (context) => RegisterPage(),
      },
    );
  }
}
