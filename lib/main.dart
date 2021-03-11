import 'package:flutter/material.dart';
import 'package:hodes_todo_app/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: kRoutes,
      title: 'Hodes TODO App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey[800]
      ),
    );
  }
}
