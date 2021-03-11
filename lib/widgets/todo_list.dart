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
    await todoListService.saveModel(newTODOItem);
    setState(() {
      items.add(newTODOItem);
    });
  }

  selectTodoItem(TODOItem item) async {
    await todoListService.saveModel(item);
  }

  deleteListItem(TODOItem item) async {
    await todoListService.deleteModel(item.id);
    setState(() {
      items.remove(item);
    });
  }

  reorderListItems(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    TODOItem oldItem = this.items.elementAt(oldIndex);
    oldItem.order = newIndex;
    TODOItem newItem = this.items.elementAt(newIndex);
    newItem.order = oldIndex;
    await todoListService.saveModel(oldItem);
    await todoListService.saveModel(newItem);
    todoListService.sortModels(this.items);
    setState(() {});
  }

  cleanDoneItems() async {
    for(TODOItem item in items){
      if(item.done == true){
        await todoListService.deleteModel(item.id);
      }
    }
    setState(() {
      items = items.where((element) => !element.done).toList();
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
    await todoListService.saveModel(item);
    setState(() {});
  }

  Widget todoListItems(List<TODOItem> items, ThemeData theme) {
    final oddItemColor = theme.colorScheme.primary.withOpacity(0.05);
    final evenItemColor = theme.colorScheme.primary.withOpacity(0.15);
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
    return ReorderableListView(
      buildDefaultDragHandles: true,
      children: [
        for (int index = 0; index < items.length; index++)
          TODOListItem(
            index: index,
            item: items[index],
            color: (even = !even) ? oddItemColor : evenItemColor,
            onStateChange: (TODOItem item) => selectTodoItem(item),
            onEdit: (TODOItem item) => editItem(item),
            onDelete: (TODOItem item) => deleteListItem(item),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        this.reorderListItems(oldIndex, newIndex);
      },
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
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.lightGreenAccent, size: 33,),
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
                Navigator.pushNamed(context, '/help');
              },
            ),
          ],
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
