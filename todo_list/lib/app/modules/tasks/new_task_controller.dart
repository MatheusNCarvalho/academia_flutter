import 'package:flutter/material.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/interfaces/todo_repository_interface.dart';
import 'package:intl/intl.dart';

class NewTaskController extends ChangeNotifier {
  final ITodoRepository repository;
  final dateFormat = DateFormat("dd/MM/yyyy");
  final formKey = GlobalKey<FormState>();
  DateTime daySelected;
  TextEditingController nomeTaskController = TextEditingController();
  var loading = false;
  String error;

  NewTaskController({
    this.repository,
    String day,
  }) {
    daySelected = dateFormat.parse(day);
  }

  String get dayFormated => dateFormat.format(daySelected);

  Future<void> save() async {
    try {
      if (!formKey.currentState.validate()) {
        return;
      }

      var model = TodoModel(
        dataHora: daySelected,
        descricao: nomeTaskController.text,
        finalizado: false,
      );

      await repository.save(model);
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }
}
