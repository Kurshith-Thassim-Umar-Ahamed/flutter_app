import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseUpdate extends StatefulWidget {
  const RealtimeDatabaseUpdate({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseUpdateState createState() => _RealtimeDatabaseUpdateState();
}

class _RealtimeDatabaseUpdateState extends State<RealtimeDatabaseUpdate> {
  final databaseRef = FirebaseDatabase.instance.reference().child("Tasks");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: SafeArea(
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

                    updateTask(snapshot.value['authname'], snapshot.value['description'], snapshot.value['techEmail'],
                        snapshot.value['finalDate'],context,snapshot.key);
                  },
                  icon: Icon(Icons.edit),
                ),
              );
            },
          ),
      ),
    );
  }

  Future<void> updateTask(String authname, String description, String techEmail, String finalDate, BuildContext context, var key){
    var nameController = TextEditingController(text: authname);
    var descriptionController = TextEditingController(text: description);
    var techEmailController = TextEditingController(text: techEmail);
    var dateController = TextEditingController(text: finalDate);

    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Update Task"),
        content: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Name"),
            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Task"),
            ),
            SizedBox(height: 5,),
            TextFormField(
              controller: techEmailController,
              decoration: InputDecoration(border: UnderlineInputBorder(),labelText: "Tech Email"),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelText: 'Date before to respond',
                  hintText: 'Pick your Date'
              ),
              onTap: ()async{
                var date =  await showDatePicker(
                    context: context,
                    initialDate:DateTime.now(),
                    firstDate:DateTime(1900),
                    lastDate: DateTime(2100));
                dateController.text = date.toString().substring(0,10);
              },
              onSaved: (value){
                finalDate=value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: (){
                UpdateTask(nameController.text, descriptionController.text, techEmailController.text, dateController.text, key);
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

  void UpdateTask(String authname, String description,String techEmail, String dateController, var key){
    Map<String, String> x = {"authname": authname, "description": description, "techEmail": techEmail, "dateController":dateController};
    databaseRef.child(key).update(x);
  }

}
