import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/views/screens/blood_level_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:aunty_rafiki/providers/utility_provider.dart';

// import from screens dir
import '../screens/tracker_screen.dart';
import '../screens/chat_screen.dart';

import '../screens/more_screen.dart';

class HomePage extends StatelessWidget {
  // list of widgets corresponding to navigation bar items
  final List<Widget> _screens = [
    TrackerScreen(),
    ChatScreen(),
    BloodLevelScreen(),
    MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: _utilityProvider.currentIndex == 1
              ? AppBar(
                leading: Container(),
                  title: Text(
                    "Chats",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    // PopupMenuButton<ChatPopMenu>(
                    //   icon: Icon(Icons.more_vert),
                    //   onSelected: (ChatPopMenu result) {
                    //     if (result == ChatPopMenu.NewGroup)
                    //       Navigator.pushNamed(context, selectContactsPage);
                    //   },
                    //   itemBuilder: (BuildContext context) =>
                    //       <PopupMenuEntry<ChatPopMenu>>[
                    //     const PopupMenuItem<ChatPopMenu>(
                    //       value: ChatPopMenu.NewGroup,
                    //       child: Text('New Group'),
                    //     ),
                    //     const PopupMenuItem<ChatPopMenu>(
                    //       value: ChatPopMenu.NewBroadcast,
                    //       child: Text('New Chat'),
                    //     ),
                    //     const PopupMenuItem<ChatPopMenu>(
                    //       value: ChatPopMenu.Settings,
                    //       child: Text('Settings'),
                    //     ),
                    //   ],
                    // )
                 
                 
                  ],
                  bottom: TabBar(
                    onTap: (index) {
                      // Tab index when user select it, it start from zero
                    },
                    tabs: [
                      Tab(text: 'Group'),
                      Tab(text: 'Chats'),
                    ],
                  ),
                )
              : null,
          body: SafeArea(child: _screens[_utilityProvider.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _utilityProvider.currentIndex,
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Tracker',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.chartLine),
                label: 'Blood Level',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'More',
              ),
            ],
            onTap: _utilityProvider.selectTab,
          ),
          floatingActionButton: _utilityProvider.currentIndex == 2
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, addBloodLevelPage);
                  },
                  child: Icon(Icons.add))
              : Container()),
    );
  }
}
