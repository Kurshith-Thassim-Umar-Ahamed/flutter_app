import 'package:flutter/material.dart';
import 'package:mad_assignment/admin_screen.dart';

class AdminPage extends StatefulWidget{
  _AdminPage createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Page',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminScreen(),
    );
  }

}