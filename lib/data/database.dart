import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  //create initial data for first time ever running app
  void createInitialData(){
    toDoList = [
      ["Subscribe to Netflix", false],
      ["Code for fun", true]
    ];
  }
  //Load the data from database
void loadData() {
  toDoList = _myBox.get(
      "TODOLIST"); //We are calling the key for the hive database with a random key
}
    //update the database

  void updateDataBase(){
  _myBox.put("TODOLIST", toDoList);
  }


}