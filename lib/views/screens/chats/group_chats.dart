import 'package:flutter/material.dart';

import 'package:aunty_rafiki/constants/routes/routes.dart';

import 'package:aunty_rafiki/models/chat.dart';

import 'package:aunty_rafiki/views/components/tiles/chat_user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChats extends StatefulWidget {
  @override
  _GroupChatsState createState() => _GroupChatsState();
}

class _GroupChatsState extends State<GroupChats> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
              onChanged: (val) {
                setState(() {
                  _searchText = val;
                });
              },
            ),
          ),
          StreamBuilder<List<Chat>>(
            stream: (_searchText != "" && _searchText != null)
                ? db
                    .collection('groups')
                    .orderBy('name')
                    .where("searchKeywords", arrayContains: _searchText)
                    .snapshots()
                    .map(firestoreToChatList)
                : db
                    .collection('groups')
                    .orderBy('name')
                    .snapshots()
                    .map(firestoreToChatList),
            builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('error: ${snapshot.error.toString()}'));
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<Chat> chatList = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatUserTile(
                      chat: chatList[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          chatRoomPage,
                          arguments: chatList[index],
                        );
                      });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
