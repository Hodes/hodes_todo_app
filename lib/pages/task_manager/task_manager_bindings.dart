
import 'package:get/get.dart';
import 'package:hodes_todo_app/pages/task_manager/task_manager_controller.dart';

class TaskManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TaskManagerController>(TaskManagerController());
  }

}