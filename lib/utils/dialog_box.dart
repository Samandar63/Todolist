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
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: "Enter task",
                  ),
                ),

                TextField(
                  controller: discriptionController,
                  decoration: InputDecoration(
                    hintText: "Enter discription",
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