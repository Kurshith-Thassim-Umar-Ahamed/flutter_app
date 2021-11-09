import 'package:flutter/material.dart';

import 'main_screen.dart';


class UserPage extends StatefulWidget{
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Page',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: MainScreen(),
    );
  }

}
/*return Scaffold(
appBar: AppBar(
title: Text('User Page'),
),
);*/


