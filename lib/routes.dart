
import 'package:flutter/material.dart';
import 'package:hodes_todo_app/pages/help_page.dart';
import 'package:hodes_todo_app/pages/home_page.dart';

final Map<String, WidgetBuilder> kRoutes = {
  '/': (context) => HomePage(title:'Hodes TODO App'),
  '/help': (context) => HelpPage()
};