import 'package:flutter/material.dart';
import 'package:mad_assignment/realtime_db/delete.dart';
import 'package:mad_assignment/realtime_db/editUserRole.dart';

import '../main.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreen createState() => _AdminHomeScreen();
}

class _AdminHomeScreen extends State<AdminHomeScreen> {

  Widget portrait(){
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Logout'),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Alert !"),
                          content: new Text("Do you want to signout"),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Signout"),
                              onPressed: (){
                                _signout();
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
                  },
                ),
                /*ElevatedButton(
                  child: Text('Edit User Role'),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditUserRole()));
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget landscape(){
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Logout'),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Alert !"),
                          content: new Text("Do you want to signout"),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Signout"),
                              onPressed: (){
                                _signout();
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
                  },
                ),
                /*ElevatedButton(
                  child: Text('Edit User Role'),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditUserRole()));
                  },
                ),*/
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
        title: Text("Admin Home"),
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

  void _signout() async{
    try{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}