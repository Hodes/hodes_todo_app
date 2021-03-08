import 'package:flutter/material.dart';
import 'package:hodes_todo_app/widgets/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hodes TODO App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey[800]
      ),
      home: TODOHome(title: 'Hodes TODO App'),
    );
  }
}

class TODOHome extends StatefulWidget {
  TODOHome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TODOHomeState createState() => _TODOHomeState();
}

class _TODOHomeState extends State<TODOHome> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TodoList(),
    );
  }
}
