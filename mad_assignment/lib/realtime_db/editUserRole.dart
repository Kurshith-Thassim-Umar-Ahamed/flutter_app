import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class EditUserRole extends StatefulWidget {
  const EditUserRole({Key? key}) : super(key: key);

  @override
  _EditUserRoleState createState() => _EditUserRoleState();
}

class _EditUserRoleState extends State<EditUserRole> {
  final databaseRef = FirebaseDatabase.instance.reference().child("Users");

  Widget portrait(){
    return SafeArea(
      child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index){
          return ListTile(
            title: Text(snapshot.value['name']),
            subtitle: Text(snapshot.value['email']),
            trailing: IconButton(
              onPressed: (){
                //var key = snapshot.key;

                updateTask(snapshot.value['role'], context,snapshot.key);
              },
              icon: Icon(Icons.edit),
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
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index){
          return ListTile(
            title: Text(snapshot.value['name']),
            subtitle: Text(snapshot.value['email']),
            trailing: IconButton(
              onPressed: (){
                //var key = snapshot.key;

                updateTask(snapshot.value['role'], context,snapshot.key);
              },
              icon: Icon(Icons.edit),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit User Role'),
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

  Future<void> updateTask(String role, BuildContext context, var key){
    var roleController = TextEditingController(text: role);

    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Update User Role"),
        content: Column(
          children: [
            TextFormField(
              controller: roleController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Name"),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: (){
                UpdateTask(roleController.text, key);
                Navigator.of(context).pop();
              },
              child: Text("Update")
          ),
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Cancel")
          ),
        ],
      );
    });
  }

  void UpdateTask(String role,  var key){
    Map<String, String> x = {"role": role};
    databaseRef.child(key).update(x);
  }

}


