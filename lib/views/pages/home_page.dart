import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
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
    return Scaffold(
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
              icon: Icon(Icons.track_changes_sharp),
              label: Languages.of(context).labelTracker,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: Languages.of(context).labelChat,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartLine),
              label: Languages.of(context).labelBloodLevel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: Languages.of(context).labelMore,
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
            : Container());
  }
}
