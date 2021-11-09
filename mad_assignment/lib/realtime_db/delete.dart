import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseDelete extends StatefulWidget {
  const RealtimeDatabaseDelete({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseDeleteState createState() => _RealtimeDatabaseDeleteState();
}

class _RealtimeDatabaseDeleteState extends State<RealtimeDatabaseDelete> {
  final databaseRef = FirebaseDatabase.instance.reference().child("Tasks");

  Widget portrait(){
    return SafeArea(
      child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,
            Animation<double> animation, int index){
          return ListTile(
            title: Text(snapshot.value['authname']),
            subtitle: Text(snapshot.value['description']),
            trailing: IconButton(
              onPressed: (){
                var key = snapshot.key;
                _deleteRecord(key);
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
  Widget landscape(){
    return SafeArea(
      child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,
            Animation<double> animation, int index){
          return ListTile(
            title: Text(snapshot.value['authname']),
            subtitle: Text(snapshot.value['description']),
            trailing: IconButton(
              onPressed: (){
                var key = snapshot.key;
                _deleteRecord(key);
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Task'),
      ),
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

  _deleteRecord(var key) async{
    await databaseRef.child(key).remove();
  }

}
