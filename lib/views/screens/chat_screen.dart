import 'package:aunty_rafiki/views/components/headers/home_screen_header.dart';
import 'package:aunty_rafiki/views/screens/chats/group_chats.dart';
import 'package:aunty_rafiki/views/screens/chats/private_chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HomeScreenHeader(
                title: 'Chats',
              ),
                TabBar(
                  labelColor: Colors.pink,
                  indicatorColor: Colors.pink,
                  onTap: (index) {
                    // Tab index when user select it, it start from zero
                  },
                  tabs: [
                    Tab(
                      text: 'Group',
                    ),
                    Tab(text: 'Chats'),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      GroupChats(),
                      PrivateChats(
                        currentUserId: FirebaseAuth.instance.currentUser.uid,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
