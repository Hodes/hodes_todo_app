

import 'package:get/get.dart';
import 'package:hodes_todo_app/services/database_service.dart';
import 'package:hodes_todo_app/services/todo_list_service.dart';

class Services {

  static void initialize() {
    Get.lazyPut(() => DatabaseService().init());
    Get.lazyPut(() => TODOListService().init());
  }

}