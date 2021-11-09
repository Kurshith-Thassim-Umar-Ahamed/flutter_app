import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mad_assignment/admin/a_home.dart';
import 'package:mad_assignment/admin/a_profile.dart';
import 'package:mad_assignment/admin/a_task.dart';
import 'package:mad_assignment/admin/user.dart';
import 'package:mad_assignment/realtime_db/updateTaskTech.dart';
import 'package:mad_assignment/realtime_db/updateUser.dart';
import 'package:mad_assignment/tech/t_home.dart';
import 'package:mad_assignment/tech/t_profile.dart';
import 'package:mad_assignment/tech/t_task.dart';

import 'navbar_key.dart';

class TechScreen extends StatefulWidget {
  @override
  _TechScreen createState() => _TechScreen();
}

class _TechScreen extends State<TechScreen> {

  int selectedIndex = 0;
  final screen = [TechHomeScreen(), UpdateTaskTech(), RealtimeDatabaseUpdateUser()];

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
        animationCurve: Curves.easeInBack,color: Colors.blueAccent,
        animationDuration: const Duration(milliseconds: 500),
      ),
      body: screen[selectedIndex],
    );
  }
}