import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mad_assignment/admin/a_home.dart';
import 'package:mad_assignment/admin/a_profile.dart';
import 'package:mad_assignment/admin/a_task.dart';
import 'package:mad_assignment/admin/user.dart';
import 'package:mad_assignment/realtime_db/delete.dart';
import 'package:mad_assignment/realtime_db/deleteUsers.dart';
import 'package:mad_assignment/realtime_db/editUserRole.dart';
import 'package:mad_assignment/realtime_db/updateUser.dart';

import 'navbar_key.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreen createState() => _AdminScreen();
}

class _AdminScreen extends State<AdminScreen> {

  int selectedIndex = 0;
  final screen = [AdminHomeScreen(), RealtimeDatabaseDeleteUser(), RealtimeDatabaseDelete(), RealtimeDatabaseUpdateUser(),EditUserRole()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIndex,
        key: NavbarKey.getKey(),
        items: [
          Icon(Icons.home, size: 30,),
          Icon(Icons.verified_user, size: 30,),
          Icon(Icons.playlist_add_rounded, size: 30,),
          Icon(Icons.person, size: 30,),
          Icon(Icons.work, size: 30,)
        ],
        buttonBackgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack, color: Colors.blue,
        animationDuration: const Duration(milliseconds: 500),
      ),
      body: screen[selectedIndex],
    );
  }
}