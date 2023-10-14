import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/database.dart';
import 'package:flutter_application_2/utils/dialog_box.dart';
import 'package:flutter_application_2/utils/todo_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // reference the hive box
  final _myBox = Hive.box("mybox");
  
  // TextController
  TextEditingController _taskController = TextEditingController();
  TextEditingController _discriptionController = TextEditingController();
  
  //List todo
  ToDoDataBase db = ToDoDataBase();

  
  // Tap checkedBox fuction
  void checkedBoxChanged(int index){
    setState(() {
      db.toDoList[index][2] =! db.toDoList[index][2];
    });
    db.updateData();
  }

  // Create a new task
  void createTask(){
    setState(() {
      db.toDoList.add([_taskController.text, _discriptionController.text, false]);
      _taskController.clear();
      _discriptionController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();    
  }

  // edit task
  void editTask(int index){ 
    
      setState(() {
        db.toDoList[index][0] = _taskController.text;
        db.toDoList[index][1] = _discriptionController.text;

        _taskController.clear();
        _discriptionController.clear();
      });
      Navigator.of(context).pop();
      db.updateData();
  }

  // delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  // if index equal -1 create task else edit task
  void editOrCreateMenu(int index){
    
    if(index != -1){
      _taskController.text = db.toDoList[index][0];
      _discriptionController.text = db.toDoList[index][1];
    }

    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          onSave: index == -1 ? createTask : () => editTask(index) , 
          onCancel: ()=> Navigator.of(context).pop(), 
          taskController: _taskController, 
          discriptionController: _discriptionController,
          
          );
      });
  } 

  @override
  void initState() {
    
    // if this app is opened first time
    if(_myBox.get("TODOLIST")== null){
      db.initalData();
    }    
    // if data is changed
    else{
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 165, 152, 152),
      // AppBar part
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            )
          ),

          title: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Icon(Icons.done_rounded, color: Colors.blue,)),
              SizedBox(width: 20,),

              const Text(
              "All list", 
                style: TextStyle(
                  fontSize: 20, 
                  fontStyle: FontStyle.italic
              )),
            ],
          )
          
        
        ),
      ),
     

      // List of tasks
      body: db.toDoList.length == 0 
      // if there is no task
      ? Container(
        child: Center(child: Text("No tasks yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)),
      )
      // if there are tasks
      :SlidableAutoCloseBehavior(
        child: ListView.builder(
          itemCount: db.toDoList.length,
          
          itemBuilder:(context, index){
            return ToDoTile(
              taskName: db.toDoList[index][0], 
              taskDifination: db.toDoList[index][1],
              isChecked: db.toDoList[index][2], 
              tapCheckedBox: (value) => checkedBoxChanged(index), 
              deleteFunction: (context) => deleteTask(index),
              editFunction: (context) => editOrCreateMenu(index), 
              
              );
          }
         ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> editOrCreateMenu(-1),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add), 
      ),
    );
  }
}

