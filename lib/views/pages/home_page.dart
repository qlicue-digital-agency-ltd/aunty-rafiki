import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';

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
    final _babyBumpProvider = Provider.of<BabyBumpProvider>(context);
    // User user = FirebaseAuth.instance.currentUser;
    // if(user.providerData.contains('interviewed')){

    // }
    return DefaultTabController(
      length: _babyBumpProvider.defaultBumps.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_utilityProvider.title),
          actions: [
            IconButton(
              tooltip: 'Appointments',
                icon: Icon(Icons.access_time),
                onPressed: () => Navigator.pushNamed(context, appointmentPage))
          ],
          bottom: _utilityProvider.currentIndex == 2
              ? TabBar(
                  onTap: (int index) {
                    _babyBumpProvider.setTabIndex(index);
                  },
                  isScrollable: true,
                  tabs: _babyBumpProvider.defaultBumps
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
      ),
    );
  }
}
