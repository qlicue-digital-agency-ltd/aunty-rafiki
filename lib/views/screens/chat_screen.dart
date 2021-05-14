import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/views/components/headers/home_screen_header.dart';
import 'package:aunty_rafiki/views/screens/chats/group_chats.dart';
import 'package:aunty_rafiki/views/screens/chats/private_chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chatProvider = Provider.of<ChatProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: HomeScreenHeader(
                        title: Languages.of(context).labelChat,
                      ),
                    ),
                    _chatProvider.selectedUsers.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.pink,
                            ),
                            onPressed: () {
                              _chatProvider.deleteUserChat();
                            })
                        : Container()
                  ],
                ),
                TabBar(
                  labelColor: Colors.pink,
                  indicatorColor: Colors.pink,
                  unselectedLabelColor: Colors.black38,
                  onTap: (index) {
                    // Tab index when user select it, it start from zero
                  },
                  tabs: [
                    Tab(
                      text: Languages.of(context).labelGroupTab,
                    ),
                    Tab(text: Languages.of(context).labelChatsTab),
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
