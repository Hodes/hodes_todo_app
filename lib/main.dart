import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodes_todo_app/routes.dart';
import 'package:hodes_todo_app/services.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Services.initialize();

    return GetMaterialApp(
      title: 'Hodes TODO App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1C2026)
      ),
      initialRoute: '/',
      getPages: Routes.buildRoutes(),
    );
  }
}
