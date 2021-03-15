import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodes_todo_app/model/todo_item.dart';
import 'package:hodes_todo_app/pages/task_manager/task_manager_controller.dart';
import 'package:hodes_todo_app/routes.dart';
import 'package:hodes_todo_app/widgets/loading_placeholder.dart';
import 'package:hodes_todo_app/widgets/todo_list_item.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class TodoList extends GetView<TaskManagerController> {

  addTodoItem({String value = "", required BuildContext context, bool done = false}) async {
    String? newDescription = await promptTask(value, context);
    if (newDescription == null) {
      return;
    }
    TODOItem newTODOItem = TODOItem(
      description: newDescription,
      done: done,
    );
    controller.addTask(newTODOItem);
  }

  taskStateChanged(TODOItem item) async {
    controller.updateTask(item);
  }

  deleteListItem(TODOItem item) async {
    controller.deleteTask(item);
  }

  reorderListItems(int oldIndex, int newIndex) async {
    controller.reorderTask(oldIndex, newIndex);
  }

  cleanDoneItems() async {
    controller.cleanDoneItems();
  }

  Future<String?> promptTask(String? currentValue, BuildContext context, {bool edit = false}) async {
    String title = edit ? 'Edit Task' : 'Add Task';
    return await prompt(
      context,
      title: Text(title),
      initialValue: currentValue,
      maxLines: 3,
      autoFocus: true,
    );
  }

  editItem(TODOItem item, BuildContext context) async {
    String? newDescription = await promptTask(item.description, context, edit: true);
    if (newDescription == null) {
      return;
    }
    item.description = newDescription;
    controller.updateTask(item);
  }

  Widget todoListItems(ThemeData theme) {
    final oddItemColor = theme.colorScheme.primary.withOpacity(0.05);
    final evenItemColor = theme.colorScheme.primary.withOpacity(0.15);
    if (controller.tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'There\'s nothing to do 😃 !',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Is this a good thing ? 😅',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      );
    }
    return ReorderableListView.builder(
        itemBuilder: (context, index) => TODOListItem(
              index: index,
              item: controller.tasks[index],
              color: index % 2 == 0 ? oddItemColor : evenItemColor,
              onStateChange: (TODOItem item) => taskStateChanged(item),
              onEdit: (TODOItem item) => editItem(item, context),
              onDelete: (TODOItem item) => deleteListItem(item),
            ),
        itemCount: controller.tasks.length,
        onReorder: (int oldIndex, int newIndex) {
          this.reorderListItems(oldIndex, newIndex);
        });
  }

  @override
  Widget build(BuildContext context) {
    this.controller.loadItems();

    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Obx(
            () => LoadingPlaceholder(
              loading: controller.isLoading.value as bool,
              child: todoListItems(
                theme,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.lightGreenAccent,
                size: 33,
              ),
              tooltip: 'Clear all completed',
              onPressed: () {
                cleanDoneItems();
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.help),
              tooltip: 'Help',
              onPressed: () {
                Get.toNamed(Routes.help);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodoItem(context: context),
        tooltip: 'Add TODO Item',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
