import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/pages/private_chat_room_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivateChartcard extends StatelessWidget {
  final DocumentSnapshot document;

  const PrivateChartcard({Key key, @required this.document}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return InkWell(
      child: Material(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: document.data()['photoUrl'] != null
                              ? CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    width: 50.0,
                                    height: 50.0,
                                    padding: EdgeInsets.all(15.0),
                                  ),
                                  imageUrl: document.data()['photoUrl'],
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.account_circle,
                                  size: 50.0,
                                  color: greyColor,
                                ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${document.data()['displayName']}',
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${document.data()['lastMessage'] ?? 'offline'}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(left: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _utilityProvider
                        .formatDate(DateTime.parse(DateTime.now().toString())),
                    style: TextStyle(
                        fontSize: 12,
                        color: document.data()['isMessageRead'] == null
                            ? Colors.pink
                            : Colors.grey.shade500),
                  ),
                ],
              ),
              Divider(indent: 60)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PrivateChatRoomPage(
                      peerId: document.id,
                      peerAvatar: document.data()['photoUrl'],
                      id: FirebaseAuth.instance.currentUser.uid,
                    )));
      },
    );
  }
}
