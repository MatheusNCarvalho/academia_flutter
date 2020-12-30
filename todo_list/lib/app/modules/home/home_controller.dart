import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/interfaces/todo_repository_interface.dart';
import 'package:collection/collection.dart';

class HomeController extends ChangeNotifier {
  final ITodoRepository repository;
  DateTime startDate;
  DateTime endDate;
  DateTime daySelected = DateTime.now();
  Map<String, List<TodoModel>> listTodos;
  String error;

  HomeController({@required this.repository}) {
    findAllForWeek();
  }

  int currentIndex = 1;

  void changeSelectedTab(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        getByFinalized();
        break;
      case 1:
        findAllForWeek();
        break;
    }
    notifyListeners();
  }

  Future<void> findAllForWeek() async {
    var dateFormat = DateFormat('dd/MM/yyyy');

    startDate = DateTime.now();

    if (startDate.weekday != DateTime.sunday) {
      startDate = startDate.subtract(Duration(days: startDate.weekday - 1));
    }

    endDate = startDate.add(Duration(days: 6));

    var todos = await repository.findByPeriod(startDate, endDate);

    if (todos.isEmpty) {
      listTodos = {
        dateFormat.format(DateTime.now()): [],
      };
      notifyListeners();
      return;
    }
    listTodos = groupBy(
      todos,
      (TodoModel todo) => dateFormat.format(todo.dataHora),
    );
    notifyListeners();
  }

  void checkedOrUncheck(TodoModel model) {
    model.finalizado = !model.finalizado;
    notifyListeners();
    repository.toggle(model);
  }

  void getByFinalized() {
    listTodos = listTodos.map(
      (key, value) {
        var todosFinalized = value.where((item) => item.finalizado).toList();
        return MapEntry(key, todosFinalized);
      },
    );
    notifyListeners();
  }

  Future<void> findTodoBySelectedDay() async {
    if (daySelected == null) {
      return;
    }

    var dateFormat = DateFormat('dd/MM/yyyy');

    var todos = await repository.findByPeriod(daySelected, daySelected);

    if (todos.isEmpty) {
      listTodos = {
        dateFormat.format(daySelected): [],
      };
      notifyListeners();
      return;
    }
    listTodos =
        groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dataHora));
    notifyListeners();
  }

  void update() {
    if (currentIndex == 0) {
      getByFinalized();
    }
    if (currentIndex == 1) {
      this.findAllForWeek();
    }

    if (currentIndex == 2) {
      this.findTodoBySelectedDay();
    }
  }

  Future<void> delete(TodoModel model) async {
    try {
      await repository.delete(model.id);
    } catch (e) {
      error = e.toString();
    } finally {
      findTodoBySelectedDay();
      getByFinalized();
    }
  }
}
