import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/database/database_adm_connection.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/home_page.dart';
import 'package:todo_list/app/modules/tasks/new_task_controller.dart';
import 'package:todo_list/app/modules/tasks/new_task_page.dart';
import 'package:todo_list/app/repositories/interfaces/todo_repository_interface.dart';
import 'package:todo_list/app/repositories/todo_repositories.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  DatabaseAdmConnection _databaseAdmConnection = DatabaseAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_databaseAdmConnection);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(_databaseAdmConnection);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ITodoRepository>(create: (_) => TodoRepository()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFFFF9129),
          buttonColor: Color(0xFFFF9129),
          textTheme: GoogleFonts.robotoTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => ChangeNotifierProvider(
                create: (context) => HomeController(
                  repository: context.read<ITodoRepository>(),
                ),
                child: HomePage(),
              ),
          '/new': (_) => ChangeNotifierProvider(
                create: (_) => NewTaskController(
                  repository: context.read<ITodoRepository>(),
                ),
                child: NewTaskPage(),
              ),
        },
      ),
    );
  }
}
