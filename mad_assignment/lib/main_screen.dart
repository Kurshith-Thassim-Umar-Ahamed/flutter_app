import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mad_assignment/navbar_key.dart';
import 'package:mad_assignment/realtime_db/updateUser.dart';
import 'package:mad_assignment/screen/home.dart';
import 'package:mad_assignment/screen/profile.dart';
import 'package:mad_assignment/screen/task.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  int selectedIndex = 0;
  final screen = [HomeScreen(), TaskScreen(), RealtimeDatabaseUpdateUser()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIndex,
        key: NavbarKey.getKey(),
        items: [
          Icon(Icons.home, size: 30,),
          Icon(Icons.playlist_add_rounded, size: 30,),
          Icon(Icons.person, size: 30,)
        ],
        buttonBackgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack, color: Colors.blueAccent,
        animationDuration: const Duration(milliseconds: 500),
      ),
      body: screen[selectedIndex],
    );
  }
}