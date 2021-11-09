import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class UpdateTaskTech extends StatefulWidget {
  const UpdateTaskTech({Key? key}) : super(key: key);

  @override
  _UpdateTaskTechState createState() => _UpdateTaskTechState();
}

class _UpdateTaskTechState extends State<UpdateTaskTech> {
  final databaseRef = FirebaseDatabase.instance.reference().child("Tasks");

  Widget portrait(){return SafeArea(
      child: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index){
          return ListTile(
            title: Text(snapshot.value['authname']),
            subtitle: Text(snapshot.value['description']),
            trailing: IconButton(
              onPressed: (){
                //var key = snapshot.key;

                updateTask(snapshot.value['techEmail'],snapshot.value['finalDate'], context,snapshot.key);
              },
              icon: Icon(Icons.email),
            ),
          );
        },
      ),
    );}
  Widget landscape(){return SafeArea(
    child: FirebaseAnimatedList(
      query: databaseRef,
      itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index){
        return ListTile(
          title: Text(snapshot.value['authname']),
          subtitle: Text(snapshot.value['description']),
          trailing: IconButton(
            onPressed: (){
              //var key = snapshot.key;

              updateTask(snapshot.value['techEmail'],snapshot.value['finalDate'], context,snapshot.key);
            },
            icon: Icon(Icons.email),
          ),
        );
      },
    ),
  );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tasks'),
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

  Future<void> updateTask(String techEmail, String finalDate,BuildContext context, var key){
    //var nameController = TextEditingController(text: authname);
    //var descriptionController = TextEditingController(text: description);
    var techEmailController = TextEditingController(text: techEmail);
    var dateController = TextEditingController(text: finalDate);

    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Update Task"),
        content: Column(
          children: [
            /*
            * TextField(
              controller: nameController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Name"),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Task"),
            ),
            SizedBox(height: 5,),
            * */

            TextFormField(
              controller: techEmailController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Tech Email"),
            ),
            SizedBox(height: 5,),
          TextFormField(
            controller: dateController,
            decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Closing Date"),
          ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: (){
                UpdateTask(techEmailController.text, key);
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

  void UpdateTask(String techEmail, var key){
    Map<String, String> x = {"techEmail": techEmail};
    databaseRef.child(key).update(x);
  }
}
