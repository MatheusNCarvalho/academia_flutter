import 'package:flutter/cupertino.dart';
import 'package:todo_list/app/repositories/interfaces/todo_repository_interface.dart';

class NewTaskController extends ChangeNotifier {
  final ITodoRepository repository;

  NewTaskController({@required this.repository});
}
