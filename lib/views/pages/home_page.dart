import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';

// import from screens dir
import '../screens/tracker_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/baby_bump_screen.dart';

import '../screens/more_screen.dart';

class HomePage extends StatelessWidget {
  // list of widgets corresponding to navigation bar items
  final List<Widget> _screens = [
    TrackerScreen(),
    ChatScreen(),
    BabyBumpScreen(),
    // AppointmentScreen(),
    MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _babyBumpProvider = Provider.of<BabyBumpProvider>(context);

    return DefaultTabController(
      length: _babyBumpProvider.defaultBumps.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_utilityProvider.title),
          actions: _utilityProvider.currentIndex == 3
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, profilePage);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/icons/female.png'),
                      ),
                    ),
                  )
                ]
              : [
                  _utilityProvider.currentIndex == 1
                      ? PopupMenuButton<ChatPopMenu>(
                          icon: Icon(Icons.more_vert),
                          onSelected: (ChatPopMenu result) {
                            if (result == ChatPopMenu.NewGroup)
                              Navigator.pushNamed(context, selectContactsPage);
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<ChatPopMenu>>[
                            const PopupMenuItem<ChatPopMenu>(
                              value: ChatPopMenu.NewGroup,
                              child: Text('New Group'),
                            ),
                            const PopupMenuItem<ChatPopMenu>(
                              value: ChatPopMenu.NewBroadcast,
                              child: Text('New Broadcast'),
                            ),
                            const PopupMenuItem<ChatPopMenu>(
                              value: ChatPopMenu.Settings,
                              child: Text('Settings'),
                            ),
                          ],
                        )
                      : IconButton(
                          tooltip: 'Appointments',
                          icon: Icon(Icons.access_time),
                          onPressed: () =>
                              Navigator.pushNamed(context, appointmentPage)
                              )
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
              icon: Icon(Icons.more_horiz),
              title: Text('More'),
            ),
          ],
          onTap: _utilityProvider.selectTab,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('/new').then((groupName) {
              String name = groupName;
              if (name != null && name.isNotEmpty) {
                db.collection('groups').doc().set({
                  'name': groupName,
                });
              }
            });
          },
        ),
      ),
    );
  }
}
