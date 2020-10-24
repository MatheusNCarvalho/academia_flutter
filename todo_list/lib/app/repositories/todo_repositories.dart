import 'package:todo_list/app/database/connection.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/interfaces/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  @override
  Future<List<TodoModel>> findByPeriod(
      DateTime startDate, DateTime endDate) async {
    var startDateOfTheDay =
        DateTime(startDate.year, startDate.month, startDate.day, 0, 0, 0);
    var endDateOfTheDay =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 29, 59);
    var conn = await Connection().instance;

    var result = await conn.rawQuery(
      "SELECT * FROM todo WHERE data_hora BETWEEN ? AND ? order by data_hora",
      [
        startDateOfTheDay.toIso8601String(),
        endDateOfTheDay.toIso8601String(),
      ],
    );

    return result.map((item) => TodoModel.fromMap(item)).toList();
  }

  @override
  Future<void> save(TodoModel model) async {
    var conn = await Connection().instance;
    conn.rawInsert("INSERT INTO todo values(?,?,?,?)", [
      null,
      model.descricao,
      model.dataHora.toIso8601String(),
      0,
    ]);
  }

  @override
  Future<void> toggle(TodoModel model) async {
    var conn = await Connection().instance;

    conn.rawUpdate("UPDATE todo SET finalizando = ? WHERE id = ?", [
      model.finalizadoToInt,
      model.id
    ]);
  }
}
