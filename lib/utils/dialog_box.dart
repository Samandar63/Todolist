import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  
  final taskController;
  final discriptionController;
  VoidCallback onSave;
  VoidCallback onCancel;
  
  DialogBox({super.key,
  required this.onSave,
  required this.onCancel,
  required this.taskController, 
  required this.discriptionController
  });

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
          content: Container(
            height: 190,
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Task title"),

                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: "Enter title here...",
                  ),
                ),

                Text("description"),

                TextField(
                  controller: discriptionController,
                  decoration: InputDecoration(
                    hintText: "Enter description here...",
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(text: "Save", onPressed: onSave),

                    SizedBox(width: 5,),
                    
                    MyButton(text: "Cancel", onPressed: onCancel)
                  ],
                )
              ],
            ),
          ),
        );
  }
}