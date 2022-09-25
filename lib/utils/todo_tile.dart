import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged; //Making the task a boolean so as to control the strikethrough
  Function(BuildContext)? deleteFunction;

  ToDoTile({Key? key, required this.taskName,
    required this.onChanged,
    required this.taskCompleted,
    required this.deleteFunction,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(), children: [
          SlidableAction(onPressed: deleteFunction, icon: Icons.delete, backgroundColor: Colors.redAccent.shade200,
          borderRadius: BorderRadius.circular(12),)
        ]),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(value: taskCompleted,
                onChanged: onChanged,
              activeColor: Colors.black,),

              //TASK NAME
              Text(taskName,
                  style: TextStyle(decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none)),//Boolean to control the strikethrough behaviour
            ],
          ),
        ),
      ),
    );
  }
}
