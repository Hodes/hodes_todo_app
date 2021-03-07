import 'package:flutter/material.dart';
import 'package:hodes_todo_app/model/todo_item.dart';
import 'package:hodes_todo_app/widgets/todo_list_item.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TODOItem> items = [];

  //TODO: Save the TODO list on storage

  addTodoItem({String value = "", bool done = false}) async {
    String newDescription = await promptTask(value);
    if(newDescription==null){
      return;
    }
    setState(() {
      items.add(TODOItem(
        description: newDescription,
        done: done,
      ));
    });
  }

  selectTodoItem(TODOItem item) {
    print('Item changed: ${item.description} now is '+(item.done? 'completed' : 'TODO'));
  }

  deleteListItem(TODOItem item) {
    setState(() {
      items.remove(item);
    });
  }

  Future<String> promptTask(String currentValue, {bool edit = false}) async {
    String title = edit ?
        'Editar Tarefa' :
        'Adicionar Tarefa';
    return await prompt(
      context,
      title: Text(title),
      textCancel: Text('Cancelar'),
      initialValue: currentValue,
      maxLines: 3,
      autoFocus: true,
    );
  }

  editItem(TODOItem item) async {
    String newDescription = await promptTask(item.description, edit: true);
    if(newDescription==null){
      return;
    }
    setState(() {
      item.description = newDescription;
    });
  }

  Widget todoListItems(List<TODOItem> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 50,
            ),
            SizedBox(height: 20,),
            Text(
              'Sua lista está vazia !',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      );
    }
    return ListView(
      children: items
          .map((TODOItem i) => TODOListItem(
                item: i,
                onStateChange: (TODOItem item) => selectTodoItem(item),
                onEdit: (TODOItem item) => editItem(item),
                onDelete: (TODOItem item) => deleteListItem(item),
              )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: todoListItems(items),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.primaryColorDark,
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