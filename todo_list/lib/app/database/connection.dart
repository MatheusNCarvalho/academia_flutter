import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list/app/database/migrations/24102020_create_table_todo.dart';

import 'migrations/migration_v2.dart';

class Connection {
  static const DATABASE_NAME = "todo_list";
  static const VERSION = 1;
  static Connection _instance;
  Database _db;
  final _lock = Lock();

  Connection._();

  factory Connection() {
    if (_instance == null) {
      _instance = Connection._();
    }
    return _instance;
  }

  Future<Database> get instance async => await _openConnection();

  Future<Database> _openConnection() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          var databasePath = await getDatabasesPath();
          var fullPath = join(databasePath, DATABASE_NAME);
          _db = await openDatabase(
            fullPath,
            version: VERSION,
            //onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
          );
        }
      });
    }
    return _db;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  // Future<FutureOr<void>> _onConfigure(Database db) async {
  //   await _db.execute("PRAGMA foreing_keys = ON");
  // }

  FutureOr<void> _onCreate(Database db, int version) {
    var batch = db.batch();
    createTableTodo(batch);
    createV2(batch);
    batch.commit();
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    var batch = db.batch();
    if (oldVersion < 2) {
      upgradeV2(batch);
    }

    batch.commit();
  }
}
