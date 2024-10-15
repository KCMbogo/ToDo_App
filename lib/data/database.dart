// ignore_for_file: unused_field

import 'package:hive/hive.dart';

class ToDoDatabase {

  List toDoList = [];

  // reference out box
  final _myBox = Hive.box('mybox');

  // create initial data
  void createInitialData() {
    toDoList = [
      ["Read a novel", false],
      ["Do exercise", false],
    ];
  }

  // load the data
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update data
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}