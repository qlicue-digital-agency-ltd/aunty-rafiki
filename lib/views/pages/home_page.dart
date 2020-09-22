import 'package:flutter/material.dart';

// import from screens dir
import '../screens/tracker_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/baby_bump_screen.dart';
import '../screens/appointment_screen.dart';
import '../screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // current selected item in bottom navigation bar
  int _currentIndex = 0;
  String _title = "Tracker";

  _selectTab(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = "Tracker";
          break;
        case 1:
          _title = "Charts";
          break;
        case 2:
          _title = "Baby Bump";
          break;
        case 3:
          _title = "Appointment";
          break;
        case 4:
          _title = "Profile";
          break;

        default:
          _title = "Tracker";
      }
    });
  }

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
      appBar: AppBar(
        title: Text(_title),
      ),
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
        onTap: _selectTab,
      ),
    );
  }
}

// tracker
// chats
// baby bump
// appointments
// profile
