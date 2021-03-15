
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodes_todo_app/pages/task_manager/task_manager_controller.dart';
import 'package:hodes_todo_app/widgets/todo_list.dart';

class TaskManagerPage extends GetView<TaskManagerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hodes TODO"),
      ),
      body: TodoList(),
    );
  }
}