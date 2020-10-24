import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/tasks/new_task_controller.dart';

class NewTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Nova task"),
          ),
          body: Container(),
        );
      },
    );
  }
}
