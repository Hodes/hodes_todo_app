import 'dart:async';

import 'package:get/get.dart';
import 'package:hodes_todo_app/model/todo_item.dart';
import 'package:hodes_todo_app/services/database_service.dart';
import 'package:sembast/sembast.dart';

class TODOListService extends GetxService {
  String? storeName;
  DatabaseService? _dbs;

  TODOListService() {
    storeName = "todo_list";
  }

  TODOListService init() {
    this._dbs = Get.find<DatabaseService>();
    return this;
  }

  TODOItem recordToModel(RecordSnapshot record) {
    return TODOItem(
        id: record.key,
        description: record.value['description'],
        done: record.value['done']);
  }

  Map<String, dynamic> modelToRecord(TODOItem model) {
    return model.toJson();
  }

  Future<List<TODOItem>> getAll() async {
    StoreRef store = this._dbs!.getMapStore(storeName);
    Database? db = await this._dbs!.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<TODOItem> result = [];
    for (var record in records) {
      result.add(recordToModel(record));
    }
    return result;
  }

  Future<TODOItem> saveModel(TODOItem item) async {
    StoreRef store = this._dbs!.getMapStore(storeName);
    Database? db = await this._dbs!.db;
    await db?.transaction((transaction) async {
      if (item.id == null) {
        int key = await store.add(transaction, modelToRecord(item));
        item.id = key;
      } else {
        await store.record(item.id).put(transaction, item.toJson());
      }
    });
    return item;
  }

  Future<TODOItem?> getModel(int id) async {
    StoreRef store = this._dbs!.getMapStore(storeName);
    Database? db = await this._dbs!.db;
    var record = await store.record(id).get(db!);
    if (record != null) {
      return recordToModel(record);
    } else {
      return null;
    }
  }

  Future<bool> deleteModel(int? id) async {
    StoreRef store = this._dbs!.getMapStore(storeName);
    Database? db = await this._dbs!.db;
    try {
      await db?.transaction((transaction) async {
        await store.record(id).delete(transaction);
      });
      return true;
    } catch (e) {
      return false;
    }
  }



}
