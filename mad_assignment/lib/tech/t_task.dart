import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class TechTaskScreen extends StatefulWidget {
  const TechTaskScreen({Key? key}) : super(key: key);

  @override
  _TechTaskScreen createState() => _TechTaskScreen();
}


class _TechTaskScreen extends State<TechTaskScreen> {
  late Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Tasks').orderByChild('finalDate');
  }

  Widget _buildTechItem({required Map tech}){
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
              color: Theme.of(context).primaryColor,
              size: 20,),
            SizedBox(width: 6,),
            Text(tech['authname'], style: TextStyle(fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600),),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 6,),
            Text(tech['description'], style: TextStyle(fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600),),
          ],),
          SizedBox(height: 10,),
          Row(children: [
            SizedBox(width: 6,),
            Text(tech['finalDate'], style: TextStyle(fontSize: 16,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600),),
            TextButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Alert!!"),
                      content: new Text("Do you want to sent email ID to customer."),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("OK"),
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
            }, child: Text('Reply'),)
          ],),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(query: _ref, itemBuilder: (BuildContext context,
            DataSnapshot snapshot, Animation<double>animation, int index){
          Map tech = snapshot.value;

          return _buildTechItem(tech: tech);
        },),
      ),
    );
  }
}