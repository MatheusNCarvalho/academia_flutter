import 'package:sqflite/sqflite.dart';

void createV2(Batch batch) {
  batch.execute('''
    CREATE TABLE IF NOT EXISTS teste (
      id Integer primary key autoincrement,
      descricao varchar(500) not null,
      data_hora datetime,
      finalizado integer
    )
   ''');
}

void upgradeV2(Batch batch) {
  batch.execute('''
    CREATE TABLE IF NOT EXISTS teste (
      id Integer primary key autoincrement,
      descricao varchar(500) not null,
      data_hora datetime,
      finalizado integer
    )
   ''');
}
