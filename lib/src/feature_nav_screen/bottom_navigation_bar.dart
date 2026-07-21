import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pele_resume/src/featrue_note/presentation/note_screen.dart';
import 'package:pele_resume/src/feature_alarm/presnetation/alarm_screen.dart';
import 'package:pele_resume/src/feature_calender/presentation/calender_screen.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/home_screen.dart';
import 'package:pele_resume/src/feature_nav_screen/constants.dart';

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    Widget body = HomeScreen();
    Widget handleBody(){
      if(index == 0)return HomeScreen();
      if(index == 1) return NoteScreen();
      if (index == 2) return CalenderScreen();
      if (index == 3) return AlarmScreen();
      throw Exception();
    }
    return Scaffold(
      body: handleBody(),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        activeIndex: index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (ind) => setState(() => index = ind),
        //other params
      ),
    );
  }
}
