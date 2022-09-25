import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the Hive Box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override //checks done when app first runs
  void initState() {
    // If this is the first time ever opening the app, create default data
    if (_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      //data already exists
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  // //List of tasks to-do
  // List toDoList = [
  //   ["Make Tutorial", false],
  //   ["Go run", true],
  // ];

  //Checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]); //Getting the text from the text controller and setting the new task as not completed by default
      _controller.clear(); //Refreshing the dialog box for the next entry
    });
    Navigator.of(context).pop();
     db.updateDataBase();
  }
  //Create a New Task

  void createNewTask(){
    showDialog(
        context: context,
        builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(), //Dismiss the dialog box
      );
     },
    );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('To Do App'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      )
    );
  }
}

