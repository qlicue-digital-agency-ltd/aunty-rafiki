import 'package:flutter/material.dart';

// import from screens dir
import '../screens/tracker.dart';
import '../screens/chat.dart';
import '../screens/baby_bump.dart';
import '../screens/appointment.dart';
import '../screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // current selected item in bottom navigation bar
  int _currentIndex = 0;

  // list of widgets corresponding to navigation bar items
  List<Widget> _screens = [
    TrackerScreen(),
    ChatScreen(),
    BabyBumpScreen(),
    AppointmentScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            title: Text('Tracker'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_size_select_actual),
            title: Text('Baby Bump'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Appointments'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        onTap: (int index) {
          // update the current index to recent selected item index in bottom navigation bar
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// tracker
// chats
// baby bump
// appointments
// profile
