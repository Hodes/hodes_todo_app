import 'package:flutter/material.dart';
import 'package:hodes_todo_app/model/todo_item.dart';
import 'package:hodes_todo_app/services/todo_list_service.dart';
import 'package:hodes_todo_app/widgets/loading_placeholder.dart';
import 'package:hodes_todo_app/widgets/todo_list_item.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final todoListService = TODOListService();

  bool loadingContent = true;
  List<TODOItem> items = [];

  @override
  void initState() {
    super.initState();
    this.loadItems();
  }

  loadItems() async {
    setState(() {
      this.loadingContent = true;
    });
    this.items = await todoListService.getAll();
    setState(() {
      this.loadingContent = false;
    });
  }

  addTodoItem({String value = "", bool done = false}) async {
    String? newDescription = await promptTask(value);
    if (newDescription == null) {
      return;
    }
    TODOItem newTODOItem = TODOItem(
      description: newDescription,
      done: done,
    );
    await todoListService.saveItem(newTODOItem);
    setState(() {
      items.add(newTODOItem);
    });
  }

  selectTodoItem(TODOItem item) async {
    await todoListService.saveItem(item);
  }

  deleteListItem(TODOItem item) async {
    await todoListService.deleteItem(item.id);
    setState(() {
      items.remove(item);
    });
  }

  Future<String?> promptTask(String? currentValue, {bool edit = false}) async {
    String title = edit ? 'Edit Task' : 'Add Task';
    return await prompt(
      context,
      title: Text(title),
      initialValue: currentValue,
      maxLines: 3,
      autoFocus: true,
    );
  }

  editItem(TODOItem item) async {
    String? newDescription = await promptTask(item.description, edit: true);
    if (newDescription == null) {
      return;
    }
    item.description = newDescription;
    await todoListService.saveItem(item);
    setState(() {});
  }

  Widget todoListItems(List<TODOItem> items, ThemeData theme) {
    if (items.isEmpty) {
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
    bool even = true;
    return ListView(
      children: items
          .map((TODOItem i) => TODOListItem(
                item: i,
                color: (even = !even) ? theme.highlightColor : null,
                onStateChange: (TODOItem item) => selectTodoItem(item),
                onEdit: (TODOItem item) => editItem(item),
                onDelete: (TODOItem item) => deleteListItem(item),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: LoadingPlaceholder(
            loading: loadingContent,
            child: todoListItems(items, theme),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodoItem(),
        tooltip: 'Add TODO Item',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
