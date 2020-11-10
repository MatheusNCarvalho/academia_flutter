import 'package:flutter/cupertino.dart';
import 'package:todo_list/app/repositories/interfaces/todo_repository_interface.dart';

class HomeController extends ChangeNotifier {
  final ITodoRepository repository;

  HomeController({@required this.repository});

  int currentIndex = 1;

  void changeSelectedTab(index){
    currentIndex = index;
    notifyListeners();
  }
}
