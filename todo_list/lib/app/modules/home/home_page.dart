import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

import '../tasks/new_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            theme: FFNavigationBarTheme(
              itemWidth: 60,
              barHeight: 70,
              barBackgroundColor: Theme.of(context).primaryColor,
              unselectedItemIconColor: Colors.white,
              unselectedItemLabelColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemIconColor: Colors.white,
              selectedItemBackgroundColor: Theme.of(context).primaryColor,
              selectedItemLabelColor: Colors.black,
            ),
            selectedIndex: controller.currentIndex,
            onSelectTab: (int index) {
              if (index == 2) {
                showDatePicker(
                  context: context,
                  initialDate: controller.daySelected,
                  firstDate: DateTime.now().subtract(Duration(days: (360 * 3))),
                  lastDate: DateTime.now().add(Duration(days: (360 * 10))),
                ).then((value) {
                  controller.daySelected = value;
                  controller.findTodoBySelectedDay();
                });
                return;
              }
              controller.changeSelectedTab(index);
            },
            items: [
              FFNavigationBarItem(
                iconData: Icons.check_circle,
                label: 'Finalizados',
              ),
              FFNavigationBarItem(
                iconData: Icons.view_week,
                label: 'Semanal',
              ),
              FFNavigationBarItem(
                iconData: Icons.calendar_today,
                label: 'Selecionar Data',
              ),
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: controller.listTodos?.keys?.length ?? 0,
              itemBuilder: (_, index) {
                var dateFormat = DateFormat('dd/MM/yyyy');
                var dayKey = controller.listTodos.keys.elementAt(index);
                var day = dayKey;
                var items = controller.listTodos[dayKey];

                if (items.isEmpty && controller.currentIndex == 0) {
                  return SizedBox.shrink();
                }

                var currentDate = DateTime.now();
                if (dayKey == dateFormat.format(currentDate)) {
                  day = 'Hoje';
                }

                if (dayKey ==
                    dateFormat.format(currentDate.add(Duration(days: 1)))) {
                  day = 'Amanha';
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(NewTaskPage.routerName);
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        var todo = items[index];

                        return ListTile(
                          leading: Checkbox(
                            activeColor: Theme.of(context).primaryColor,
                            value: todo.finalizado,
                            onChanged: (_) {
                              controller.checkedOrUncheck(todo);
                            },
                          ),
                          title: Text(
                            todo.descricao,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: todo.finalizado
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Text(
                            '${todo.dataHora.hour}: ${todo.dataHora.minute}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: todo.finalizado
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
