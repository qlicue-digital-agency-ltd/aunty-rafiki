import 'package:aunty_rafiki/models/baby_bump.dart';
import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import from screens dir
import '../screens/tracker_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/baby_bump_screen.dart';
import '../screens/appointment_screen.dart';
import '../screens/profile_screen.dart';

class HomePage extends StatelessWidget {
  // list of widgets corresponding to navigation bar items
  final List<Widget> _screens = [
    TrackerScreen(),
    ChatScreen(),
    BabyBumpScreen(),
    AppointmentScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _babyBumpProvider = Provider.of <BabyBumpProvider>(context);
    return DefaultTabController(
      length: _babyBumpProvider.babyBumps.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_utilityProvider.title),
          bottom: _utilityProvider.currentIndex == 2
              ? TabBar(
                  onTap: (int index) {
                    _babyBumpProvider.setTabIndex(index);
                  },
                  isScrollable: true,
                  tabs: _babyBumpProvider.babyBumps
                      .map((e) => Tab(
                            icon: Text(e.id.toString()),
                            text: 'Month',
                          ))
                      .toList())
              : null,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Appointments'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
          onTap: _utilityProvider.selectTab,
        ),
      ),
    );
  }
}
