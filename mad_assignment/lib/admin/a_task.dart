import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mad_assignment/realtime_db/delete.dart';

class AdminTaskScreen extends StatefulWidget {
  const AdminTaskScreen({Key? key}) : super(key: key);
  @override
  _AdminTaskScreen createState() => _AdminTaskScreen();
}

class _AdminTaskScreen extends State<AdminTaskScreen> {
  late Query _ref;

  DatabaseReference databaseRef = FirebaseDatabase.instance.reference().child(
      "Tasks");
  final myref = FirebaseDatabase.instance
      .reference()
      .child("Tasks")
      .push()
      .key;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Tasks').orderByChild(
        'finalDate');
  }


  Widget _buildTechItem({required Map tech}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 150,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(children: [
            Icon(Icons.person,
              color: Theme
                  .of(context)
                  .primaryColor,
              size: 20,),
            SizedBox(width: 6,),
            Text(tech['authname'], style: TextStyle(fontSize: 16,
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w600),),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 6,),
            Text(tech['description'], style: TextStyle(fontSize: 16,
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w600),),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 6,),
            Text(tech['finalDate'], style: TextStyle(fontSize: 16,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600),),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Alert!!"),
                      content: new Text("Do you want to delete this task"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Delete"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          child: new Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }, child: Text('Delete'),)
          ],),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref, itemBuilder: (BuildContext context,
            DataSnapshot snapshot, Animation<double>animation, int index) {
          Map tech = snapshot.value;
          var myref = snapshot.key;
          return _buildTechItem(tech: tech);
        },),
      ),
    );
  }


}
