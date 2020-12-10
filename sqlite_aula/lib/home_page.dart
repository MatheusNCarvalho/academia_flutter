import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List _elements = [
    {'name': 'John', 'group': 'Team A'},
    {'name': 'Will', 'group': 'Team B'},
    {'name': 'Beth', 'group': 'Team A'},
    {'name': 'Miranda', 'group': 'Team B'},
    {'name': 'Mike', 'group': 'Team C'},
    {'name': 'Danny', 'group': 'Team C'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grouped List View Example'),
      ),
      body: GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['name'].compareTo(item2['name']),
        order: GroupedListOrder.DESC,
        // useStickyGroupSeparators: true,
        useStickyGroupSeparators: true,
        groupHeaderBuilder: (value) {
          return Text("Teste");
        },
        // groupSeparatorBuilder: (String value) => Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     value,
        //     textAlign: TextAlign.center,
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        // ),
        itemBuilder: (c, element) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(Icons.account_circle),
                title: Text(element['name']),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openConnection() async {
    var databasePath = await getDatabasesPath();
    var fullPath = join(databasePath, "sqlite_aula");

    openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) {
        var batch = db.batch();
        batch.execute(
            "CREATE TABLE teste(id Integer primary key autoincrement, nome varchar(200))");
        batch.execute(
            "CREATE TABLE produto(id Integer primary key autoincrement, nome varchar(200))");
        batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        var batch = db.batch();
        batch.execute(
            "CREATE TABLE teste(id Integer primary key autoincrement, nome varchar(200))");
        batch.execute(
            "CREATE TABLE produto(id Integer primary key autoincrement, nome varchar(200))");
        batch.commit();
      },
    );
  }
}
