import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pele_resume/src/featrue_note/presentation/note_screen.dart';
import 'package:pele_resume/src/feature_alarm/presnetation/alarm_screen.dart';
import 'package:pele_resume/src/feature_calender/presentation/calender_screen.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/pages/add_screen.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/pages/home_screen.dart';
import 'package:pele_resume/src/feature_nav_screen/constants.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const NoteScreen(),
    const CalenderScreen(),
    const AlarmScreen(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.note,
    Icons.calendar_month,
    Icons.alarm,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}