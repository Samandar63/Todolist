import 'package:hive/hive.dart';

class ToDoDataBase{

  List toDoList = [];

  // referace the box
  final _myBox = Hive.box("mybox");

  // intial data
  void initalData(){
    toDoList = [];
  }
  
  // load data
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  // update data
  void updateData(){
    _myBox.put("TODOLIST", toDoList);
  }
}