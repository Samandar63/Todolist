import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  
  final String taskName;
  final String taskDifination;
  final bool isChecked;
  Function(bool?) tapCheckedBox;  
  Function(BuildContext) deleteFunction;
  Function(BuildContext) editFunction;
  
  ToDoTile({
    super.key, 
    required this.taskName,
    required this.isChecked,
    required this.tapCheckedBox,
    required this.deleteFunction,
    required this.editFunction, 
    required this.taskDifination
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 25, left: 25, top: 25),
      child: Slidable(
         
        endActionPane: ActionPane(
          motion:StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10)
                ),
              ),

             SlidableAction(
              onPressed: editFunction,
              backgroundColor: Colors.green,
              icon: Icons.edit,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
              )
          ]),
          
        child: Container(
                
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(192, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
    
                child: Center(
                  child: ListTile(
                    leading: Checkbox(
                              value:isChecked , 
                              onChanged: tapCheckedBox, 
                              activeColor: Colors.green,),
                    
                    title: Text(taskName, style: TextStyle(decoration: isChecked
                              ?TextDecoration.lineThrough 
                              :TextDecoration.none),),
                    
                    subtitle:Text(taskDifination) ,
                  ),
                )

              ),
      ),
    );
  }
}

