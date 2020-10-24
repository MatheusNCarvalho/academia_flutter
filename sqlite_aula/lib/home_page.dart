import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _openConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _openConnection() async {
    var databasePath = await getDatabasesPath();
    var fullPath = join(databasePath, "sqlite_aula");

    openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) {
        var batch = db.batch();
        batch.execute(
            "CREATE TABLE teste(id Integer primary key autoincrement, nome varchar(200))");
        batch.execute(
            "CREATE TABLE produto(id Integer primary key autoincrement, nome varchar(200))");
        batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        var batch = db.batch();
        batch.execute(
            "CREATE TABLE teste(id Integer primary key autoincrement, nome varchar(200))");
        batch.execute(
            "CREATE TABLE produto(id Integer primary key autoincrement, nome varchar(200))");
        batch.commit();
      },
    );
  }
}
