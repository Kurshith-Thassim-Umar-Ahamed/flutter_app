import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseDeleteUser extends StatefulWidget {
  const RealtimeDatabaseDeleteUser({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseDeleteUserState createState() => _RealtimeDatabaseDeleteUserState();
}

class _RealtimeDatabaseDeleteUserState extends State<RealtimeDatabaseDeleteUser> {
  final databaseRef = FirebaseDatabase.instance.reference().child("Users");

  Widget portrait(){
    return SafeArea(
      child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,
            Animation<double> animation, int index){
          return ListTile(
            title: Text(snapshot.value['name']),
            subtitle: Text(snapshot.value['email']),
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
            title: Text(snapshot.value['name']),
            subtitle: Text(snapshot.value['email']),
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
        title: Text('Delete Users'),
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
