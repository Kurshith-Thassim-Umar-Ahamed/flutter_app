import 'package:flutter/material.dart';
import 'package:mad_assignment/admin_screen.dart';
import 'package:mad_assignment/tech_screen.dart';

class TechPage extends StatefulWidget{
  _TechPage createState() => _TechPage();
}

class _TechPage extends State<TechPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Page',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TechScreen(),
    );
  }

}