import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  _AdminUserScreen createState() => _AdminUserScreen();
}

class _AdminUserScreen extends State<AdminUserScreen> {
  //----------------------------------------------------------------------------------------------
  final _auth = FirebaseAuth.instance;

  inputData() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    print(uid);
    return uid;
  }
  late String s  = inputData().toString();

  late Query _ref=FirebaseDatabase.instance.reference().child('Users');
//ask miss ******************************************************************************************


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
            Text(tech['name'], style: TextStyle(fontSize: 16,
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w600),),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 6,),
            Text(tech['role'], style: TextStyle(fontSize: 16,
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.w600),),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 6,),
            TextButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Alert!!"),
                      content: new Text("Do you want to delete this user"),
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

          return _buildTechItem(tech: tech);

        },),
      ),
    );
  }

}