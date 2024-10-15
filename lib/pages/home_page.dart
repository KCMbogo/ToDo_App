// pages/home_page.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:to_do/data/database.dart";
import "package:to_do/utils/dialog_box.dart";
import "package:to_do/utils/todo_tile.dart";

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the box
  final _myBox = Hive.box('mybox');

  // manage the text field
  final _controller = TextEditingController();

  // list of the to do's
  // List toDoList = [];

  @override
  void initState() {
    super.initState();
    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  // instantiate toDoDatabase to get toDoList
  ToDoDatabase db = ToDoDatabase();

  // change the state of checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(), 
        );
      });
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],

        appBar: AppBar(
          title: Text("TO DO", style: TextStyle(fontWeight: FontWeight.bold),), 
          backgroundColor: Colors.yellow, 
          centerTitle: true
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.yellow,
          child: Icon(Icons.add),
        ),

        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      );
  }
}