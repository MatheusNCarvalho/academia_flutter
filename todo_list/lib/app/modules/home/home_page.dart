import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Atividades",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          bottomNavigationBar: FFNavigationBar(
            selectedIndex: currentIndex,
          ),
          body: Container(),
        );
      },
    );
  }
}
