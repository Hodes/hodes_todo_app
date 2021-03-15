
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hodes_todo_app/pages/help/help_page.dart';
import 'package:hodes_todo_app/pages/task_manager/task_manager_bindings.dart';
import 'package:hodes_todo_app/pages/task_manager/task_manager_page.dart';

class Routes {

  static final String home = '/';
  static final String help = '/help';

  static List<GetPage> buildRoutes() {
    return [
      GetPage(name: home, page: () => TaskManagerPage(), binding: TaskManagerBinding()),
      GetPage(name: help, page: () => HelpPage()),
    ];
  }

}