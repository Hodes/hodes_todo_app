
import 'package:get/get.dart';
import 'package:hodes_todo_app/model/todo_item.dart';
import 'package:hodes_todo_app/services/todo_list_service.dart';

class TaskManagerController extends GetxController {

  var isLoading = true.obs;
  var tasks = [].obs;

  late TODOListService? _todoListService;

  @override
  void onInit() {
    super.onInit();
    this._todoListService = Get.find<TODOListService>();
  }

  loadItems() async {
    isLoading(true);
    this.tasks(await _todoListService?.getAll());
    isLoading(false);
  }

  addTask(TODOItem item) async {
    item.order = tasks.length;
    await _todoListService?.saveModel(item);
    this.tasks.add(item);
  }

  updateTask(TODOItem item) async {
    await _todoListService?.saveModel(item);
    tasks.refresh();
  }

  deleteTask(TODOItem item) async {
    await _todoListService?.deleteModel(item.id);
    this.tasks.remove(item);
  }

  reorderTask(int oldIndex, int newIndex) async {
    if(newIndex>oldIndex){
      newIndex-=1;
    }
    final oldItem = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, oldItem);
    //Change Orders
    for(int i=0; i<tasks.length; i++){
      var item = tasks.elementAt(i) as TODOItem;
      if(item.order != i){
        item.order = i;
        await _todoListService?.saveModel(item);
      }
    }
    tasks.refresh();
  }

  cleanDoneItems() async {
    for(int i=0; i<tasks.length; i++){
      var item = tasks.elementAt(i) as TODOItem;
      if(item.done){
        await _todoListService?.deleteModel(item.id);
      }
    }
    tasks(tasks.where((element) => !element.done).toList());
  }

  sortTasks() {
    tasks.sort((itemA, itemB) {
      if(itemA.order < itemB.order){
        return -1;
      }else if(itemA.order > itemB.order){
        return 1;
      }else{
        return 0;
      }
    });
  }

}