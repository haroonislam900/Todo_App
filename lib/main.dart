import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/todo_home.dart';
import 'package:to_do_app/todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider()..loadtaskfromsharedprefs(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: TodoHome(),
    );
  }
}
