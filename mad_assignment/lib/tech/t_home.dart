import 'package:flutter/material.dart';

import '../main.dart';

class TechHomeScreen extends StatefulWidget {
  const TechHomeScreen({Key? key}) : super(key: key);

  @override
  _TechHomeScreen createState() => _TechHomeScreen();
}

class _TechHomeScreen extends State<TechHomeScreen> {

  Widget portrait(){
    return SingleChildScrollView(
      child: Center(
        child: ElevatedButton(
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
      ),
    );
  }
  Widget landscape(){
    return SingleChildScrollView(
      child: Center(
        child: ElevatedButton(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technician Home'),
      ),
      backgroundColor: Colors.white,
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