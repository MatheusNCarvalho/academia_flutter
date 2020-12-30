import 'package:todo_list/app/models/todo_model.dart';

abstract class ITodoRepository {
  Future<List<TodoModel>> findByPeriod(DateTime startDate, DateTime endDate);
  Future<void> save(TodoModel model);
  Future<void> toggle (TodoModel model);
  Future<void> delete(int id);
}
