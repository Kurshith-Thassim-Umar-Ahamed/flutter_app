import 'package:flutter/material.dart';
import 'package:mad_assignment/realtime_db/updateTask.dart';
import 'package:mad_assignment/tech/view_task.dart';

import '../add_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  Widget portrait(){
    return SingleChildScrollView(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Add a Task'),
                  onPressed: (){
                    _addtask();
                  },
                ),
                ElevatedButton(
                  child: Text('View My Tasks'),
                  onPressed: (){
                    _viewtask();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget landscape(){
    return SingleChildScrollView(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Add a Task'),
                  onPressed: (){
                    _addtask();
                  },
                ),
                ElevatedButton(
                  child: Text('View My Tasks'),
                  onPressed: (){
                    _viewtask();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if(orientation == Orientation.portrait){
            return portrait();
          }else{
            return landscape();
          }
        },

      ),

    );
  }

  void _addtask() {
    try{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  void _viewtask() {
    try{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>RealtimeDatabaseUpdate()));
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
