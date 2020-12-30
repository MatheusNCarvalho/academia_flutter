import 'package:sqflite/sqflite.dart';

void createTableTodo(Batch batch) {
  batch.execute('''
    CREATE TABLE IF NOT EXISTS todo (
      id Integer primary key autoincrement,
      descricao varchar(500) not null,
      data_hora datetime,
      finalizado integer
    )
   ''');
}
