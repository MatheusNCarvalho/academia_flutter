import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/tasks/new_task_controller.dart';
import 'package:todo_list/app/shared/time_component.dart';

class NewTaskPage extends StatefulWidget {
  static String routerName = "/new";

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewTaskController>(context, listen: false).addListener(() {
        var controller = context.read<NewTaskController>();
        if (controller.error != null) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(controller.error),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Todo cadastrado com sucessso"),
            backgroundColor: Colors.green[600],
          ),
        );
        Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<NewTaskController>(context, listen: false)
        .removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskController>(
      builder: (context, controller, _) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NOVA TASK",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Data",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.dayFormated,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Nome da Task",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.nomeTaskController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) {
                        controller.nomeTaskController.text = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Nome da Task obrigatório';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Hora",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TimeComponent(
                      date: controller.daySelected,
                      onSelectedTime: (newDate) {
                        print("Nova Data $newDate");
                        controller.daySelected = newDate;
                      },
                    ),
                    SizedBox(height: 50),
                    _buildButton(controller, context)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(NewTaskController controller, BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => controller.save(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              // BoxShadow(
              //   blurRadius: 30,
              //   color: Theme.of(context).primaryColor,
              // ),
            ],
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Salvar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
