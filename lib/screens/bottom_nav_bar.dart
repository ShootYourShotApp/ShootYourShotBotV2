import 'package:flutter/material.dart';
import 'package:sysbotv2/screens/main/lets_voice_chat.dart';
import 'package:sysbotv2/screens/main/level_up_screen.dart';
import 'package:sysbotv2/screens/main/rizz_report.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  // List of screens to display for each tab
  final List<Widget> _screens = [
    RizzReport(),
    LevelUpScreen(),
    LetsVoiceChat()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 76,
        child: BottomNavigationBar(
          currentIndex: _currentIndex, // Track the selected index
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update the selected index
            });
          },
          backgroundColor: Colors.black,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xff979797),
          selectedLabelStyle: TextStyle(
              fontFamily: 'Avenir', fontWeight: FontWeight.w500, fontSize: 13),
          unselectedLabelStyle: TextStyle(
              fontFamily: 'Avenir', fontWeight: FontWeight.w500, fontSize: 13),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child:
                Image.asset('assets/images/score-card-icon.png', width: 24),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child:
                Image.asset('assets/images/score-card-icon.png', color: Colors.white, width: 24),
              ),
              label: 'score card',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child:
                Image.asset('assets/images/level-up-icon.png', width: 23),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child:
                Image.asset('assets/images/level-up-icon.png', width: 23, color: Colors.white),
              ),
              label: 'level up',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/images/coach-icon.png', width: 20),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/images/coach-icon.png', width: 20, color: Colors.white),
              ),
              label: 'coach',
            ),
          ],
        ),
      ),
    );
  }
}
