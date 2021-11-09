import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseUpdateUser extends StatefulWidget {
  const RealtimeDatabaseUpdateUser({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseUpdateUserState createState() => _RealtimeDatabaseUpdateUserState();
}

class _RealtimeDatabaseUpdateUserState extends State<RealtimeDatabaseUpdateUser> {
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

                updateTask(snapshot.value['name'], snapshot.value['email'], context,snapshot.key);
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

                updateTask(snapshot.value['name'], snapshot.value['email'], context,snapshot.key);
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
        title: Text('Update User'),
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

  Future<void> updateTask(String name, String email, BuildContext context, var key){
    var nameController = TextEditingController(text: name);
    var emailController = TextEditingController(text: email);

    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Update User"),
        content: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Name"),
            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Email"),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: (){
                UpdateTask(nameController.text, emailController.text, key);
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

  void UpdateTask(String name, String email, var key){
    Map<String, String> x = {"name": name, "email": email};
    databaseRef.child(key).update(x);
  }

}

