import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import from screens dir
import '../screens/tracker_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/baby_bump_screen.dart';

import '../screens/profile_screen.dart';

class HomePage extends StatelessWidget {
  // list of widgets corresponding to navigation bar items
  final List<Widget> _screens = [
    TrackerScreen(),
    ChatScreen(),
    BabyBumpScreen(),
    // AppointmentScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_utilityProvider.title),
        actions: [
          IconButton(
              icon: Icon(Icons.business),
              onPressed: () => Navigator.pushNamed(context, appointmentPage))
        ],
      ),
      body: _screens[_utilityProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _utilityProvider.currentIndex,
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.business),
          //   title: Text('Appointments'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        onTap: _utilityProvider.selectTab,
      ),
    );
  }
}
