import 'package:hodes_todo_app/model/todo_item.dart';
import 'package:hodes_todo_app/services/database_service.dart';
import 'package:sembast/sembast.dart';

class TODOListService  {
  String storeName;

  TODOListService() {
    storeName = "todo_list";
  }

  TODOItem recordToModel(RecordSnapshot record) {
    return TODOItem(
        id: record.key,
        description: record.value['description'],
        done: record.value['done']
    );
  }

  Future<List<TODOItem>> getAll() async {
    DatabaseService dbs = DatabaseService();
    StoreRef store = dbs.getMapStore(storeName);
    var records = await store.find(
        await dbs.db, finder: Finder()
    );
    List<TODOItem> result = [];
    for (var record in records) {
      result.add(recordToModel(record));
    }
    return result;
  }

  Future<TODOItem> saveItem(TODOItem item) async {
    DatabaseService dbs = DatabaseService();
    StoreRef store = dbs.getMapStore(storeName);
    Database db = await dbs.db;
    await db.transaction((transaction) async {
      if (item.id == null) {
        int key = await store.add(transaction, item.toMap());
        item.id = key;
      } else {
        await store.record(item.id).put(transaction, item.toMap());
      }
    });
    return item;
  }

  Future<TODOItem> getItem(int id) async {
    DatabaseService dbs = DatabaseService();
    StoreRef store = dbs.getMapStore(storeName);
    Database db = await dbs.db;
    var record = await store.record(id).get(db);
    if(record != null){
      return recordToModel(record);
    }else{
      return null;
    }
  }

  Future<bool> deleteItem(int id) async {
    DatabaseService dbs = DatabaseService();
    StoreRef store = dbs.getMapStore(storeName);
    Database db = await dbs.db;
    try{
      await db.transaction((transaction) async {
        await store.record(id).delete(transaction);
      });
      return true;
    }catch(e){
      return false;
    }
  }

}
