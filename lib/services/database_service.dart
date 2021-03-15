import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

const APP_DATABASE_FILENAME = 'todolist.db';

class DatabaseService extends GetxService {

  Database? _db;

  DatabaseService init() {
    return this;
  }

  Future<Database?> get db async {
    if(_db != null){
      return _db;
    }
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String dbFilePath = "${appDocDirectory.path}/$APP_DATABASE_FILENAME";
    DatabaseFactory dbFactory = databaseFactoryIo;
    _db = await dbFactory.openDatabase(dbFilePath);
    return _db;
  }

  StoreRef getMapStore(String? storeName) {
    return intMapStoreFactory.store(storeName);
  }

  StoreRef<String, String> getMainStore() {
    return StoreRef<String, String>.main();
  }
}